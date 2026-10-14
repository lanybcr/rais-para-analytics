-- PAM/IBGE: junta lavouras temporárias e permanentes numa só lista (só Pará).
-- valor_producao vem em MIL reais (padrão do IBGE).
select
    ano, id_municipio, 'temporaria' as tipo_lavoura, produto,
    area_colhida, quantidade_produzida, valor_producao
from {{ source('basedosdados_pam', 'lavoura_temporaria') }}
where sigla_uf = 'PA' and ano between 2015 and 2025

union all

select
    ano, id_municipio, 'permanente' as tipo_lavoura, produto,
    area_colhida, quantidade_produzida, valor_producao
from {{ source('basedosdados_pam', 'lavoura_permanente') }}
where sigla_uf = 'PA' and ano between 2015 and 2025
