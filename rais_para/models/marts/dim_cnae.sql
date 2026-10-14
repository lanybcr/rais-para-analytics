-- Lista de apoio: uma classe de atividade (setor) por linha.
-- A RAIS usa 99999 quando o setor não é informado; não existe na lista oficial,
-- então adicionamos uma linha "Não classificado" para o JOIN não perder esses vínculos.
select * from {{ ref('stg_cnae') }}

union all

select '99999', 'Não classificado', '00', 'Não classificado', 'ZZ', 'Não classificado'
