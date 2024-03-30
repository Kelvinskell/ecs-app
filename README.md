# ecs-app
This project uses terraform to automate the deployment of a containerized application to Amazon Elastic Container Service (ECS).


## How to use
- Clone the repository.
- Switch into the cloned repository and `cd` into the terraform directory.
- Run `terraform init`
- Run `terraform validate` to validate the source code synatx.
- Run `terraform plan` to view proposed infrastructure changes.
- Run `terraform apply -auto-approve` to provision the infrastructure and deploy the application.
