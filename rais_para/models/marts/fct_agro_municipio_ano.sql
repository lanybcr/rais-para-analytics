-- Cruzamento RAIS x PAM. Granularidade: 1 linha = ano x município.
-- "Agro" na RAIS = CNAE divisões 01 (agricultura/pecuária), 02 (florestal) e 03 (pesca).
-- Produção (PAM) existe até 2024; em 2025 as colunas de produção ficam nulas.
with emprego as (
    select
        ano,
        id_municipio,
        sum(qtd_vinculos)                                                 as vinculos_total,
        sum(case when substr(id_cnae_classe, 1, 2) in ('01','02','03')
                 then qtd_vinculos else 0 end)                            as vinculos_agro
    from {{ ref('fct_vinculos') }}
    group by 1, 2
),

producao as (
    select
        ano,
        id_municipio,
        sum(valor_producao)                                               as valor_producao_mil_reais,
        sum(area_colhida)                                                 as area_colhida_ha
    from {{ ref('stg_pam_lavoura') }}
    group by 1, 2
)

select
    e.ano,
    e.id_municipio,
    e.vinculos_total,
    e.vinculos_agro,
    p.valor_producao_mil_reais,
    p.area_colhida_ha
from emprego e
left join producao p using (ano, id_municipio)
