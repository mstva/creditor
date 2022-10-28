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

#### Development Environment:
- Set Environment Variables:
  - Copy `crewtech_api/.env.sample/` folder and rename it to `crewtech_api/.env/`.
  - Update the `crewtech_api/.env/.env.development` file.
- Run the script to start docker compose:
  ```shell
  sh crewtech_scripts/run_development.sh local
  ```
- Push to the server:
  ```shell
  rsync -r crewtech_api crewtech_scripts/run_development.sh root@server_api_address:/root/crewtech
  ```
- Run the script on the server:
  ```shell
  ssh root@server_api_address "sh crewtech/run_development.sh"
  ```
- Check logs:
  ```shell
  ssh root@server_api_address "docker logs crewtech_development_django"
  ```

#### Staging Environment:
- Set Environment Variables:
  - Copy `crewtech_api/.env.sample/` folder and rename it to `crewtech_api/.env/`.
  - Update the `crewtech_api/.env/.env.staging` file.
- Run the script to start docker compose:
  ```shell
  sh crewtech_scripts/run_staging.sh local
  ```
- Push to the server:
  ```shell
  rsync -r crewtech_api crewtech_scripts/run_staging.sh root@server_api_address:/root/crewtech
  ```
- Run the script on the server:
  ```shell
  ssh root@server_api_address "sh crewtech/run_staging.sh"
  ```
- Check logs:
  ```shell
  ssh root@server_api_address "docker logs crewtech_staging_django"
  ```

#### Production Environment:
- Set Environment Variables:
  - Copy `crewtech_api/.env.sample/` folder and rename it to `crewtech_api/.env/`.
  - Update the `crewtech_api/.env/.env.production` file.
- Run the script to start docker compose:
  ```shell
  sh crewtech_scripts/run_production.sh local
  ```
- Push to the server:
  ```shell
  rsync -r crewtech_api crewtech_scripts/run_production.sh root@server_api_address:/root/crewtech
  ```
- Run the script on the server:
  ```shell
  ssh root@server_api_address "sh crewtech/run_production.sh"
  ```
- Check logs:
  ```shell
  ssh root@server_api_address "docker logs crewtech_production_django"
  ```

