# Terraform — create secret with CMK, tags, rotation  
#Creation — IaC implementation
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


# CloudWatch alarm — rotation failure alert
resource "aws_cloudwatch_metric_alarm" "rotation_failure" {
  alarm_name          = "secrets-rotation-failure"
  namespace           = "AWS/SecretsManager"
  metric_name         = "RotationFailed"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = [aws_sns_topic.security_alerts.arn]
}

# EventBridge rule for rotation failure events
{
  "source": ["aws.secretsmanager"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["secretsmanager.amazonaws.com"],
    "eventName": ["RotationFailed", "RotationAborted"]
  }
}
# Targets: SNS → PagerDuty, Lambda → auto-remediation workflow

#IAM policy — least-privilege consumer access

{
  "Effect": "Allow",
  "Action": [
    "secretsmanager:GetSecretValue",
    "secretsmanager:DescribeSecret"
  ],
  "Resource": "arn:aws:secretsmanager:us-east-1:123456789:secret:/prod/myapp/*",
  "Condition": {
    "StringEquals": {
      "aws:sourceVpce": "vpce-0a1b2c3d4e5f",
      "aws:PrincipalTag/Environment": "production"
    }
  }
}