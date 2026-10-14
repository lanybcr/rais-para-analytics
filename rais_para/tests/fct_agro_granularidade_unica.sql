select ano, id_municipio, count(*) as n
from {{ ref('fct_agro_municipio_ano') }}
group by 1, 2
having count(*) > 1
