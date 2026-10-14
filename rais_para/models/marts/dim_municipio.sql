-- Lista de apoio: um município por linha (144 no Pará).
select * from {{ ref('stg_municipio') }}
