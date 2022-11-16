## Crewtech Infrastructure using Terraform.

The Crewtech infrastructure on DigitalOcean using Terraform.

### Setup and Running:

#### - Setup SSH:

- Generate an SSH Key.
- Create a folder with the name `.ssh` under `src` folder.
- Copy `id_rsa.pub` file to `src/.ssh`.

#### - Setup Terraform Backend:

- Create a file and name it to `backend.hcl` under `src` folder.
- Copy the below content inside it and fill the values as mentioned.

```hcl
bucket = ""
key = ""
region = ""
endpoint = ""
access_key = ""
secret_key = ""
skip_credentials_validation = true
```

#### - Setup Secrets:

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

#### - Run Terraform commands for src folder with Docker Compose:

- terraform init
    ```shell
    docker compose run --rm terraform -chdir=src init -backend-config=backend.hcl
    ```

---

- terraform plan all
    ```shell
    docker compose run --rm terraform -chdir=src plan
    ```
- terraform plan digitalocean
    ```shell
    docker compose run --rm terraform -chdir=src plan -target="module.digitalocean"
    ```
- terraform plan cloudamqp
    ```shell
    docker compose run --rm terraform -chdir=src plan -target="module.cloudamqp"
    ```
- terraform plan circleci
    ```shell
    docker compose run --rm terraform -chdir=src plan -target="module.circleci"
    ```

--- 
 
- terraform apply all
    ```shell
    docker compose run --rm terraform -chdir=src apply --auto-approve
    ```
- terraform apply digitalocean
    ```shell
    docker compose run --rm terraform -chdir=src apply -target="module.digitalocean" --auto-approve
    ```
- terraform apply cloudamqp
    ```shell
    docker compose run --rm terraform -chdir=src apply -target="module.cloudamqp" --auto-approve
    ```
- terraform apply circleci
    ```shell
    docker compose run --rm terraform -chdir=src apply -target="module.circleci" --auto-approve
    ```

---

- terraform destroy all
    ```shell
    docker compose run --rm terraform -chdir=src destroy --auto-approve
    ```
- terraform destroy digitalocean
    ```shell
    docker compose run --rm terraform -chdir=src destroy -target="module.digitalocean" --auto-approve
    ```
- terraform destroy cloudamqp
    ```shell
    docker compose run --rm terraform -chdir=src destroy -target="module.cloudamqp" --auto-approve
    ```
- terraform destroy circleci
    ```shell
    docker compose run --rm terraform -chdir=src destroy -target="module.circleci" --auto-approve
    ```

---

- terraform output digitalocean
    ```shell
    docker compose run --rm terraform -chdir=src output digitalocean
    ```
- terraform output cloudamqp
    ```shell
    docker compose run --rm terraform -chdir=src output cloudamqp
    ```
  
