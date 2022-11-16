## Crewtech Infrastructure using Terraform.

The Crewtech infrastructure on DigitalOcean using Terraform.

### Setup and Running:

#### 1- Setup SSH:

- Generate an SSH Key.
- Create a folder with the name `.ssh` under `src` folder.
- Copy `id_rsa.pub` file to `src/.ssh`.

#### 2- Setup Secrets:

- Create a file with the name `secrets.auto.tfvars` under `src` folder.
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

circleci = {
  api_token    = ""
  vcs_type     = ""
  organization = ""
}

circleci_contexts = {

  common = {
    CIRCLE_TOKEN       = ""
    CIRCLE_OWNER_ID    = ""
    DOCKERHUB_USERNAME = ""
    DOCKERHUB_PASS     = ""
  }

  base = {
    # copy the base environment variables like this
    ENV_VAR = "ENV_VALUE"
  }

  development = {
    # copy the development environment variables like this
    ENV_VAR = "ENV_VALUE"
  }

  staging = {
    # copy the staging environment variables like this
    ENV_VAR = "ENV_VALUE"
  }

  production = {
    # copy the production environment variables like this
    ENV_VAR = "ENV_VALUE"
  }
  
}

# How to create new token for digital ocean
# https://cloud.digitalocean.com/account/api/tokens/new

# How to setup space key for digital ocean
# https://www.digitalocean.com/community/tutorials/how-to-create-a-digitalocean-space-and-api-key

# Create Cloudamqp API key
# https://customer.cloudamqp.com/apikeys

# Create CircleCI Token
# https://app.circleci.com/settings/user/tokens
```

#### 3- Setup Terraform Backend:

- Create a file and name it to `backend.hcl` under `src` folder.
- Copy the below content inside it and fill the values as mentioned.

```hcl
bucket                      = ""
key                         = ""
region                      = ""
endpoint                    = ""
access_key                  = ""
secret_key                  = ""
skip_credentials_validation = true
```

#### 4- Run Terraform commands for src folder with Docker Compose:

- terraform init
    ```shell
    docker compose run --rm terraform -chdir=src init -backend-config=backend.hcl
    ```
- terraform plan
    ```shell
    docker compose run --rm terraform -chdir=src plan
    ```
- terraform apply
    ```shell
    docker compose run --rm terraform -chdir=src apply --auto-approve
    ```
- terraform destroy
    ```shell
    docker compose run --rm terraform -chdir=src destroy --auto-approve
    ```
- terraform output development
    ```shell
    docker compose run --rm terraform -chdir=src output development
    ```
- terraform output staging
    ```shell
    docker compose run --rm terraform -chdir=src output staging
    ```
- terraform output production
    ```shell
    docker compose run --rm terraform -chdir=src output production
    ```
