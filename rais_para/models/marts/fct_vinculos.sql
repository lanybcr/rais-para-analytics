-- Granularidade: 1 linha = ano x município x classe CNAE x escolaridade.
-- Só vínculos ativos em 31/12 (medida padrão de "emprego formal").
-- Lê a view de staging UMA vez (~1,6 GB); o Power BI lê esta tabela pequena.
select
    ano,
    id_municipio,
    id_cnae_classe,
    case when cod_escolaridade in ('1','2','3','4','5','6','7','8','9','10','11')
         then cod_escolaridade else '99' end        as cod_escolaridade,
    count(*)                                        as qtd_vinculos,
    sum(valor_remuneracao_dezembro)                 as massa_remuneracao_dezembro,
    avg(valor_remuneracao_dezembro)                 as remuneracao_media_dezembro
from {{ ref('stg_rais_vinculos') }}
where is_ativo_3112
group by 1, 2, 3, 4
