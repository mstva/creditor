### CrewTech API
A backend API using Python, Django and PostgresSQL.

### Setup the infrastructure:
- Read `crewtech_infrastructure/README.md` to follow the instructions.


### Run with Docker Locally:

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
    python crewtech_scripts/get_infra_output.py --env=development
    ```
  - Update the `backend/.env/.env.development` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/development.yml up -d --build
    ```


- **Run the staging environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python crewtech_scripts/get_infra_output.py --env=staging
    ```
  - Update the `backend/.env/.env.staging` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/staging.yml up -d --build
    ```


- **Run the production environment:**
  - Get the environment variables from the infrastructure:
    ```shell
    python crewtech_scripts/get_infra_output.py --env=production
    ```
  - Update the `backend/.env/.env.production` file. 
  - Run docker compose:
    ```shell
    docker compose -f backend/.docker-compose/production.yml up -d --build
    ```
    
### Setup for deployment:
- Read `crewtech_scripts/generate_circleci_config/README.md` to generate CircleCI config.yml












