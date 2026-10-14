-- Lista de apoio escrita à mão: a RAIS usa códigos 1 a 11.
-- O código 99 junta "ignorado" (-1) e qualquer valor fora da lista.
select * from unnest([
    struct('1'  as cod_escolaridade, 'Analfabeto'                  as escolaridade, 1  as ordem),
    struct('2',  'Até 5ª ano incompleto',        2),
    struct('3',  '5ª ano completo (fundamental)', 3),
    struct('4',  '6ª ao 9ª ano (fundamental)',    4),
    struct('5',  'Fundamental completo',          5),
    struct('6',  'Médio incompleto',              6),
    struct('7',  'Médio completo',                7),
    struct('8',  'Superior incompleto',           8),
    struct('9',  'Superior completo',             9),
    struct('10', 'Mestrado',                      10),
    struct('11', 'Doutorado',                     11),
    struct('99', 'Não informado',                 99)
])
