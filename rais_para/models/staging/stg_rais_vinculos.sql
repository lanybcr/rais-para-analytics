-- Só Pará e 2015 em diante: a tabela de origem é clusterizada por sigla_uf,
-- então este filtro faz o BigQuery ler uma fração pequena dela (economia).
-- Selecionamos só as colunas que vamos usar (BigQuery cobra por coluna lida).
select
    cast(ano as int64)                              as ano,
    id_municipio,
    cnae_2                                          as id_cnae_classe,
    cast(grau_instrucao_apos_2005 as string)        as cod_escolaridade,
    sexo,
    cast(idade as int64)                            as idade,
    tipo_vinculo,
    tamanho_estabelecimento,
    valor_remuneracao_media,
    valor_remuneracao_dezembro,
    (vinculo_ativo_3112 = '1')                      as is_ativo_3112
from {{ source('basedosdados_rais', 'microdados_vinculos') }}
where sigla_uf = 'PA'
  and ano >= 2015
