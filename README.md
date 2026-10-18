# Emprego formal no Pará (RAIS): do dado público ao dashboard

Peguei uma base pública enorme (478 GB de microdados da RAIS), tratei, organizei e transformei num dashboard que responde a uma pergunta de negócio. **Custo de infraestrutura: zero.**

**[Ver o case completo](https://lanybcr.github.io/rais-para-analytics/)**, a história do projeto em uma página.

> **Pergunta:** como evoluiu o emprego formal nos municípios do Pará na última década, por setor e escolaridade, e onde o agro gerou mais vagas formais?

## O dashboard

| Visão geral | Setor e escolaridade | Agro no Pará |
|---|---|---|
| ![Visão geral](docs/img/pagina1.png) | ![Setor e escolaridade](docs/img/pagina2.png) | ![Agro no Pará](docs/img/pagina3.png) |

## O que os dados mostraram

- **O emprego formal no Pará cresceu de 1,13 mi (2015) para 1,45 mi (2024) vínculos**, com queda em 2016 e alta de 2,76% em 2024.
- **Produção alta não significa emprego formal alto.** Igarapé-Miri (açaí, R$ 13,9 bi em 10 anos) tinha só 60 vínculos no agro em 2024; Paragominas (grãos e pecuária, R$ 11,1 bi) tinha 3.960.
- **O valor da produção agrícola cresceu muito mais que o emprego:** de R$ 10 bi para R$ 36 bi, enquanto os vínculos agro foram de 53 mil para 63 mil.
- **Onde o agro mais abriu vagas formais (2015–2024):** Santa Isabel do Pará (+2.325), Paragominas (+1.004) e Santana do Araguaia (+714).

## O que foi entregue

- **Extração** de bases públicas no BigQuery (RAIS, produção agrícola do IBGE, cadastro de municípios), filtrando só o necessário.
- **Tratamento e modelagem** com dbt: dados organizados em modelo estrela (fatos e dimensões), prontos para análise.
- **Controle de qualidade:** 24 testes automáticos que conferem duplicidades, campos vazios e ligações entre tabelas.
- **Dashboard em Power BI** com 3 páginas e medidas documentadas ([`docs/medidas_dax.md`](docs/medidas_dax.md)).
- **Custo zero:** BigQuery gratuito, trava de 10 GB por consulta e Power BI em modo Import.
- **Transparência:** limitações dos dados declaradas (valores sem correção da inflação, só emprego formal etc.).

**Ferramentas:** SQL · BigQuery · dbt · Power BI (DAX) · Git

## Posso fazer o mesmo com os seus dados

O mesmo processo serve para planilhas, sistemas internos ou bases públicas (RAIS, IBGE, CAGED, DataSUS): organizar os dados, garantir que estão corretos e entregar um painel que responde às suas perguntas.

## Para quem quer ver por dentro

- [Metodologia, modelo de dados, testes e limitações](docs/metodologia.md)
- [Como rodar o projeto](docs/como_rodar.md)
- Código dbt em [`rais_para/`](rais_para/) · arquivo do dashboard em [`dashboard/rais_para.pbix`](dashboard/rais_para.pbix)
