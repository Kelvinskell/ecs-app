# ecs-app
This project uses terraform to automate the deployment of a containerized application to Amazon Elastic Container Service (ECS).

This is a terraform project that automates the provisioning of all necessary infrastructure required  - and automatically deploys a containerized python aplication to Amazon Elastic Container Service (AWS ECS).


## How to use
- Clone the repository.
- Switch into the cloned repository and `cd` into the terraform directory.
- Run `terraform init`
- Run `terraform validate` to validate the source code synatx.
- Run `terraform plan` to view proposed infrastructure changes.
- Run `terraform apply -auto-approve` to provision the infrastructure and deploy the application.

The DNS name of the application load balancer attached to the load balancer is printed out as [terraform output](https://developer.hashicorp.com/terraform/language/values/outputs) once the apply is complete.


## How To Contribute
