# Terraform — create secret with CMK, tags, rotation
resource "aws_secretsmanager_secret" "app_db" {
  name       = "/prod/myapp/db/credentials"
  kms_key_id = aws_kms_key.secrets_cmk.arn
  recovery_window_in_days = 30

  tags = {
    Owner          = "platform-team"
    Environment    = "production"
    Classification = "confidential"
    RotationPolicy = "90days"
  }
}

resource "aws_secretsmanager_secret_rotation" "app_db" {
  secret_id           = aws_secretsmanager_secret.app_db.id
  rotation_lambda_arn = aws_lambda_function.rotate_rds.arn
  rotation_rules {
    automatically_after_days = 90
  }
}