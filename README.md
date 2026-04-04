# Terraform_Multi-_Environment


terraform plan -out=tfplan && terraform apply -auto-approve "tfplan"
terraform destroy -auto-approve

# To only destry only EC2 instance
terraform destroy -target=aws_instance.my-instance -auto-approve

terraform apply -target=aws_instance.my-instance -auto-approve

Using modules we reuse the terraform templates for varopus environments in production.


https://github.com/LondheShubham153/terraform-for-devops