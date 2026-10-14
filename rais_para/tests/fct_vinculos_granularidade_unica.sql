-- Falha se existir mais de uma linha para a mesma combinação
-- ano x município x classe CNAE x escolaridade.
select ano, id_municipio, id_cnae_classe, cod_escolaridade, count(*) as n
from {{ ref('fct_vinculos') }}
group by 1, 2, 3, 4
having count(*) > 1
