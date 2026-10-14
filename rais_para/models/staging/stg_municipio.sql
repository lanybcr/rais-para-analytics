select
    id_municipio,
    nome                      as nome_municipio,
    nome_microrregiao,
    nome_mesorregiao,
    nome_regiao_imediata,
    nome_regiao_intermediaria,
    amazonia_legal
from {{ source('basedosdados_diretorios', 'municipio') }}
where sigla_uf = 'PA'
