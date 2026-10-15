# Como rodar o projeto

Pré-requisitos: Python 3.12, [Google Cloud SDK](https://cloud.google.com/sdk) e uma conta Google com um projeto no BigQuery (o **sandbox gratuito** basta, sem cartão).

```bash
python -m venv .venv
.venv/Scripts/activate            # Windows (Linux/Mac: source .venv/bin/activate)
pip install -r requirements.txt

gcloud auth application-default login
```

Edite `rais_para/profiles.yml` e troque `project:` pelo ID do seu projeto. O login é via OAuth do gcloud, então não há senha nem chave no repositório.

```bash
cd rais_para
dbt run  --profiles-dir .
dbt test --profiles-dir .
dbt docs generate --profiles-dir . && dbt docs serve --profiles-dir .
```

## Decisões para ficar 100% no plano gratuito

- **BigQuery sandbox:** 10 GB de armazenamento e 1 TB de consultas por mês, sem cobrança.
- **Trava de custo:** `maximum_bytes_billed` de 10 GB no `profiles.yml`; o dbt recusa qualquer consulta que leia mais que isso.
- **Filtro sempre por `sigla_uf = 'PA'`** na tabela da RAIS, e `dry run` antes de consultas grandes.
- **Staging como view, marts como tabela:** views não ocupam espaço nem expiram.
- **Power BI em modo Import**, para não consumir cota do BigQuery a cada clique. Não foi publicado no Power BI Service, que exige licença paga.

## Tabelas do sandbox expiram em 60 dias

No sandbox, as **tabelas** (os marts) são apagadas após 60 dias. As views não expiram. Para recriar tudo, rode `dbt run --profiles-dir .` de novo (poucos minutos, dentro da cota gratuita). O `.pbix` guarda uma cópia dos dados e continua abrindo normalmente.
