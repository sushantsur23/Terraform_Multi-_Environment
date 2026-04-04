variable "dynamo_table_name"{
    type = string
    default = "free-bootcamp-table"
    description = " This is dynamo db table"
}
variable "ami_id"{
    default = "ami-07062e2a343acc423"
    type = string
    description = "this is Ami id for Ubuntu EC2 instance"
}