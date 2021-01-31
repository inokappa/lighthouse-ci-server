# CloudWatch Logs
resource "aws_cloudwatch_log_group" "lighthouse-ci-server" {
  name              = "lighthouse-ci-server"
  retention_in_days = 3
}
