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

You can simply copy the DNS name and paste in your browser to access the application. Beware however that it takes about 5 to 8 minutes for the application to be fully deployed.


## How To Contribute

### Pull requests are welcome!
For major changes, please open an issue first to discuss what you would like to change. Please make sure to update the README.md file as appropriate.

### Procedures
1. Fork it!
2. (Optional) Clone to your local repository: https://github.com/Kelvinskell/ecs-app.git or git@github.com:Kelvinskell/ecs-app.git
3. Create your feature branch: git checkout -b new-feature
4. Commit your changes: git commit -am 'add-some-new-feature
5. Push to the branch: git push origin new-feature
6. Submit a pull request
