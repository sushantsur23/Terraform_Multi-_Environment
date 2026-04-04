module "dev-app"  {
    source = "./aws_infra"
    my-env = "dev"
    instance_type = "t2.micro"
    ami_id  = "ami-07062e2a343acc423"
    instance_count = 1
} 

module "staging-app"  {
    source = "./aws_infra"
    my-env = "dev"
    instance_type = "t2.medium"
    ami_id  = "ami-07062e2a343acc423"
    instance_count = 1
} 

module "prd-app"  {
    source = "./aws_infra"
    my-env = "dev"
    instance_type = "t2.large"
    ami_id  = "ami-07062e2a343acc423"
    instance_count = 3
} 