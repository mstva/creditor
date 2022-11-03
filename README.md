### CrewTech API
A backend API using Python, Django and PostgresSQL.

### Setup the infrastructure:
- Read `crewtech_infrastructure/README.md` to follow the instructions.


### Run with Docker Locally:

- **Set the environment variables:**
  - Copy `crewtech_api/.env.sample/` folder to `crewtech_api/.env/`.


- **Run the base environment:**
  - Update the `crewtech_api/.env/.env.base` file. 
  - Run docker compose:
    ```shell
    docker compose -f crewtech_api/.docker-compose/base.yml up -d --build
    ```


- **Run the development environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python crewtech_scripts/get_infra_output.py --env=development
    ```
  - Update the `crewtech_api/.env/.env.development` file. 
  - Run docker compose:
    ```shell
    docker compose -f crewtech_api/.docker-compose/development.yml up -d --build
    ```


- **Run the staging environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python crewtech_scripts/get_infra_output.py --env=staging
    ```
  - Update the `crewtech_api/.env/.env.staging` file. 
  - Run docker compose:
    ```shell
    docker compose -f crewtech_api/.docker-compose/staging.yml up -d --build
    ```


- **Run the production environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python crewtech_scripts/get_infra_output.py --env=production
    ```
  - Update the `crewtech_api/.env/.env.production` file. 
  - Run docker compose:
    ```shell
    docker compose -f crewtech_api/.docker-compose/production.yml up -d --build
    ```
    
### Setup for deployment:
- Read `crewtech_scripts/generate_circleci_config/README.md` to generate CircleCI config.yml












