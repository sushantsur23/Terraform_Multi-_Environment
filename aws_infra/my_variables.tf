variable "my_env" {
    description = " This is my environment for infra"
    type = string

}

variable "ami_id" {
    description = " This is my ami id for EC2"
    type = string
    
}

variable "instance_type" {
    description = " This is the type of instance for EC2"
    type = string
    
}

variable "instance_count" {
    description = " This is the count of instance for EC2"
    type = number
    
}