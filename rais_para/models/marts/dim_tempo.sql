-- Lista de apoio: um ano por linha (2015 a 2025, a década analisada).
select ano, ano - 2015 + 1 as ano_da_decada
from unnest(generate_array(2015, 2025)) as ano
