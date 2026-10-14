-- O diretório tem uma linha por subclasse; a RAIS usa o nível "classe" (5 dígitos).
-- Aqui deixamos uma linha por classe. A classe 25390 vinha duplicada só por uma
-- quebra de linha no texto da divisão, então normalizamos os espaços antes.
select distinct
    classe                                                  as id_cnae_classe,
    regexp_replace(descricao_classe, r'\s+', ' ')           as descricao_classe,
    divisao                                                 as id_cnae_divisao,
    regexp_replace(descricao_divisao, r'\s+', ' ')          as descricao_divisao,
    secao                                                   as id_cnae_secao,
    regexp_replace(descricao_secao, r'\s+', ' ')            as descricao_secao
from {{ source('basedosdados_diretorios', 'cnae_2') }}
