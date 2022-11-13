### CrewTech API
A backend API using Python, Django and PostgresSQL.

### Setup the infrastructure:
- Read `infrastructure/README.md` to follow the instructions.


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
    
### Setup for deployment:
- Read `scripts/generate_circleci_config/README.md` to generate CircleCI config.yml












