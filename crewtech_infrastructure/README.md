## Crewtech Infrastructure using Terraform.
The Crewtech infrastructure on DigitalOcean using Terraform.

### DigitalOcean:

#### 1- Setup SSH:
- Generate an SSH Key.
- Create a folder with the name `.ssh` under `digital_ocean` folder.
- Copy `id_rsa.pub` file to `digital_ocean/.ssh`.

#### 2- Setup Secrets:
- Create a file with the name `secrets.auto.tfvars` under `digital_ocean` folder.
- Copy the below content inside it and fill the values as mentioned.

```terraform
digitalocean = {
  token             = ""
  spaces_access_id  = ""
  spaces_secret_key = ""
}

cloudamqp = {
  api_key = "",
}

# How to create new token
# https://cloud.digitalocean.com/account/api/tokens/new

# How to setup space key
# https://www.digitalocean.com/community/tutorials/how-to-create-a-digitalocean-space-and-api-key

# Create Cloudamqp API key
# https://customer.cloudamqp.com/apikeys
```

#### 3- Setup Terraform Backend:

- Create a file and name it to `backend.hcl` under `digital_ocean` folder.
- Copy the below content inside it and fill the values as mentioned.

```hcl
bucket = ""
key    = ""
region = ""
endpoint = ""
access_key = ""
secret_key = ""
skip_credentials_validation = true
```

#### 4- Run Terraform commands for digital_ocean folder with Docker Compose:
- terraform init
    ```shell
    docker compose run --rm terraform -chdir=digital_ocean init -backend-config=backend.hcl
    ```
- terraform plan
    ```shell
    docker compose run --rm terraform -chdir=digital_ocean plan
    ```
- terraform apply
    ```shell
    docker compose run --rm terraform -chdir=digital_ocean apply --auto-approve
    ```
- terraform destroy
    ```shell
    docker compose run --rm terraform -chdir=digital_ocean destroy --auto-approve
    ```
- terraform output development
    ```shell
     sh terraform_output.sh development ../crewtech_api/.env/.env.development
    ```
- terraform output staging
    ```shell
     sh terraform_output.sh staging ../crewtech_api/.env/.env.staging
    ```
- terraform output production
    ```shell
     sh terraform_output.sh production ../crewtech_api/.env/.env.production
    ```
---

### CircleCI:

#### 1- Setup Secrets:
- Create a file with the name `secrets.auto.tfvars` under `circleci` folder.
- Copy the below content inside it and fill the values as mentioned.

```terraform
api_token = "https://app.circleci.com/settings/user/tokens"
vcs_type = "github"
organization = "organization name"

env_development = {
  # just copy .env.development file here
}

env_staging = {
  # just copy .env.staging file here 
}

env_production = {
  # just copy .env.production file here
}
```
#### 2- Setup Terraform Backend:

- Create a file and name it to `backend.hcl` under `circleci` folder.
- Copy the below content inside it and fill the values as mentioned.

```hcl
bucket = ""
key    = "circleci/terraform.tfstate"
region = "region"
endpoint = "endpoint"
access_key = "access key"
secret_key = "secret key"
skip_credentials_validation = true
```

#### 3- Run Terraform commands for circleci folder with Docker Compose:
- terraform init
    ```shell
    docker compose run --rm terraform -chdir=circleci init -backend-config=backend.hcl
    ```
- terraform plan
    ```shell
    docker compose run --rm terraform -chdir=circleci plan
    ```
- terraform apply
    ```shell
    docker compose run --rm terraform -chdir=circleci apply --auto-approve
    ```
- terraform destroy
    ```shell
    docker compose run --rm terraform -chdir=circleci destroy --auto-approve
    ```
