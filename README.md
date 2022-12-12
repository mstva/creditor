## Creditor API
A full production backend API using these tech stacks:
- REST API: _Django and Django REST Framework_.
- Database: _PostgresSQL_.
- Unit Testing: _Pytest_.
- Packaging Management: _Poetry_.
- Containerization: _Docker and Docker Compose_.
- Cloud Provider: _Digital Ocean_.
- Infrastructure as Code: _Terraform_.
- CI/CD: _CircleCI_.
- Version Control: _Git and GitHub_.
- Message Broker: _RabbitMQ_.
- Cache: _Redis_.

## Backend:

- **Set the environment variables:**
  - Copy `backend/.env.sample/` folder to `backend/.env/`.

- **Run the base environment:**
  - Update the `backend/.env/.env.base` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/base.yml up -d --build
    ```

- **Run the development environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python scripts/get_infra_output.py --env=development --compose=infrastructure/docker-compose.yml
    ```
  - Update the `backend/.env/.env.development` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/development.yml up -d --build
    ```

- **Run the staging environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python scripts/get_infra_output.py --env=staging --compose=infrastructure/docker-compose.yml
    ```
  - Update the `backend/.env/.env.staging` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/staging.yml up -d --build
    ```

- **Run the production environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python scripts/get_infra_output.py --env=production --compose=infrastructure/docker-compose.yml
    ```
  - Update the `backend/.env/.env.production` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/production.yml up -d --build
    ```

## Infrastructure:

#### - Setup SSH:
- Generate an SSH Key.
- Create a folder with the name `.ssh` under `infrastructure` folder.
- Copy `id_rsa.pub` file to `infrastructure/.ssh`.

#### - Setup Terraform Backend:
- Create a file and name it to `.backend.hcl` under `infrastructure` folder.
- Copy the content of file `.backend.hcl.sample` inside it and fill the values.

#### - Setup Secrets:
- Create a file with the name `secrets.auto.tfvars` under `infrastructure` folder.
- Copy the content of file `.secrets.auto.tfvars.sample` inside it and fill the values.

#### - Run Terraform commands:

- terraform init
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform init -backend-config=.backend.hcl
    ```

---

- terraform plan all
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform plan
    ```
- terraform plan digitalocean
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform plan -target="module.digitalocean"
    ```
- terraform plan cloudamqp
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform plan -target="module.cloudamqp"
    ```
- terraform plan circleci
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform plan -target="module.circleci"
    ```

--- 
 
- terraform apply all
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform apply --auto-approve
    ```
- terraform apply digitalocean
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform apply -target="module.digitalocean" --auto-approve
    ```
- terraform apply cloudamqp
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform apply -target="module.cloudamqp" --auto-approve
    ```
- terraform apply circleci
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform apply -target="module.circleci" --auto-approve
    ```

---

- terraform destroy all
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform destroy --auto-approve
    ```
- terraform destroy digitalocean
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform destroy -target="module.digitalocean" --auto-approve
    ```
- terraform destroy cloudamqp
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform destroy -target="module.cloudamqp" --auto-approve
    ```
- terraform destroy circleci
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform destroy -target="module.circleci" --auto-approve
    ```

---

- terraform output digitalocean
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform output digitalocean
    ```
- terraform output cloudamqp
    ```shell
    docker compose -f infrastructure/.docker-compose.yml run --rm terraform output cloudamqp
    ```

## Deployment:
- Read `scripts/generate_circleci_config/README.md` to generate CircleCI config.yml












