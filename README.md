# terraform-app

Project to create a web application using terraform

Configure your app in the `variables.tf` file.

## Variables

Configure your app in the `terraform.tfvars` file.

Example: Bitbucket Server

```hcl
webapp_subdomain       = "bbs"
webapp_name            = "bbs"
webapp_image           = "atlassian/bitbucket:latest"
webapp_port            = 7990
```

Example: Jenkins

```hcl
webapp_subdomain       = "jenkins"
webapp_name            = "jenkins"
webapp_image           = "jenkins/jenkins:latest"
webapp_port            = 8080
```

Example: Nexus

```hcl
webapp_subdomain       = "nexus"
webapp_name            = "nexus"
webapp_image           = "sonatype/nexus3:latest"
webapp_port            = 8081
```

## Usage

Create a `backend.conf` file with the following content:

```hcl
bucket = "my-terraform-state-bucket"
key    = "terraform.tfstate"
region = "us-east-1"
```

Then run the following commands:

```bash
terraform init -backend-config="backend.conf"
terraform plan -out="tfplan"
terraform apply "tfplan"
```
