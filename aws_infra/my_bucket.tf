# S3 bucket
resource "aws_s3_bucket" "my-bucket" {
  bucket = "${var.my_env}-testflight-bucket"

  tags = {
    Name        = "${var.my_env}-Sushant-Devops-bootcamp"
    environment = var.my_env
  }
}