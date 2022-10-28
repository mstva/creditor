### CrewTech API
A backend API using Python, Django and PostgresSQL.

### Run with Docker:

#### Base Environment:
- Set Environment Variables:
  - Copy `crewtech_api/.env.sample/` folder to `crewtech_api/.env/`.
  - Update the `crewtech_api/.env/.env.base` file.
- Run Postgres
    ```shell
    docker compose -f crewtech_api/.docker-compose/base.yml up postgres -d 
    ```
- Run docker compose base services
    ```shell
    docker compose -f crewtech_api/.docker-compose/base.yml up -d --build
    ```
