# Medidas DAX do dashboard

Criar em Modelagem > Nova medida. Para editar uma existente, clique nela na lista de campos e altere a fórmula.

Vínculos são um **estoque** (foto em 31/12), então NÃO se somam entre anos: a medida pega o último ano do filtro.
A produção agrícola também usa o último ano do filtro, para ficar comparável com os vínculos do mesmo ano. A fonte vem em mil reais; a medida converte para bilhões.

```dax
Vínculos =
VAR a = MAX ( dim_tempo[ano] )
RETURN CALCULATE ( SUM ( fct_vinculos[qtd_vinculos] ), dim_tempo[ano] = a )

Massa Salarial Dez =
VAR a = MAX ( dim_tempo[ano] )
RETURN CALCULATE ( SUM ( fct_vinculos[massa_remuneracao_dezembro] ), dim_tempo[ano] = a )

Remuneração Média = DIVIDE ( [Massa Salarial Dez], [Vínculos] )

Vínculos Ano Anterior =
CALCULATE (
    [Vínculos],
    FILTER ( ALL ( dim_tempo[ano] ), dim_tempo[ano] = MAX ( dim_tempo[ano] ) - 1 )
)

Variação Anual % = DIVIDE ( [Vínculos] - [Vínculos Ano Anterior], [Vínculos Ano Anterior] )

Vínculos Agro =
VAR a = MAX ( dim_tempo[ano] )
RETURN CALCULATE ( SUM ( fct_agro_municipio_ano[vinculos_agro] ), dim_tempo[ano] = a )

Valor Produção (R$ bi) =
VAR a = MAX ( dim_tempo[ano] )
RETURN DIVIDE (
    CALCULATE ( SUM ( fct_agro_municipio_ano[valor_producao_mil_reais] ), dim_tempo[ano] = a ),
    1000000
)

Vínculos Agro por R$ 1 mi produzido =
VAR a = MAX ( dim_tempo[ano] )
RETURN DIVIDE (
    [Vínculos Agro],
    CALCULATE ( SUM ( fct_agro_municipio_ano[valor_producao_mil_reais] ), dim_tempo[ano] = a ) / 1000
)
```

Remuneração Média usa massa / vínculos (média ponderada). Valores em reais correntes (sem correção pela inflação).
