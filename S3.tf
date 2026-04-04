resource "aws_s3_bucket" "my-bucket" {
  bucket = "testflight-bucket"

  tags = {
    Name        = "Sushant Devops bootcamp"
    Environment = "Dev"
  }
}