# Metodologia e detalhes técnicos

## Arquitetura

```
Base dos Dados (BigQuery público)          dbt (BigQuery)                         Power BI
 br_me_rais.microdados_vinculos  ─┐   staging (views)      marts (tabelas)
 br_bd_diretorios_brasil         ─┼─► stg_rais_vinculos ─► fct_vinculos ──────┐
 br_ibge_pam (lavouras)          ─┘   stg_municipio     ─► dim_municipio      ├─► modo Import
                                      stg_cnae          ─► dim_cnae           │   (relações
                                      stg_pam_lavoura   ─► fct_agro_municipio_ano   dimensão → fato)
                                                           dim_escolaridade, dim_tempo
```

## Modelo estrela

- `fct_vinculos`: ano × município × classe CNAE × escolaridade (~420 mil linhas). Só vínculos ativos em 31/12.
- `fct_agro_municipio_ano`: ano × município, com vínculos agro (CNAE divisões 01, 02 e 03) e produção agrícola (PAM/IBGE).
- Dimensões: `dim_municipio` (144), `dim_cnae` (672), `dim_escolaridade` (12), `dim_tempo` (2015–2025).

## Testes

24 testes de dados (`not_null`, `unique`, `relationships` e testes singulares de granularidade única, em `rais_para/tests/`). Staging não tem testes de propósito: testar uma view releria a tabela fonte de 478 GB.

## Limitações

- **Vínculos são um estoque (foto em 31/12), não um fluxo.** Não são somados entre anos: as medidas usam o último ano do filtro. Não mostram admissões e demissões.
- **Salários em reais nominais** (sem correção pela inflação), então comparações entre anos superestimam o ganho real.
- **A produção (PAM/IBGE) vai só até 2024 e cobre apenas lavouras** (temporária e permanente). Pecuária, extrativismo e silvicultura ficam de fora. Por isso o dashboard mostra 2015–2024; o 2025 existe na RAIS mas foi excluído dos filtros.
- **"Agro" na RAIS** = CNAE divisões 01 (agricultura e pecuária), 02 (silvicultura) e 03 (pesca e aquicultura).
- A RAIS cobre apenas emprego **formal**; a informalidade, importante no agro paraense, não aparece.

## Fontes

- [Base dos Dados](https://basedosdados.org): `br_me_rais`, `br_ibge_pam`, `br_bd_diretorios_brasil`.
- RAIS: Ministério do Trabalho e Emprego. PAM: IBGE.
