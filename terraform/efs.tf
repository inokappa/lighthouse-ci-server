# EFS
resource "aws_efs_file_system" "lighthouse-ci-server" {
  creation_token                  = "lighthouse-ci-server"
  # provisioned_throughput_in_mibps = "50"
  # throughput_mode                 = "provisioned"
 
  tags = {
    Name = "lighthouse-ci-server"
    ManagedBy = "Terraform"
  }
}
 
# EFS Mount Target
resource "aws_efs_mount_target" "lighthouse-ci-server-1a" {
  file_system_id = aws_efs_file_system.lighthouse-ci-server.id
  subnet_id      = var.subnet-1a
  security_groups = [
    aws_security_group.lighthouse-ci-server-efs-sg.id
  ]
}
 
resource "aws_efs_mount_target" "lighthouse-ci-server-1c" {
  file_system_id = aws_efs_file_system.lighthouse-ci-server.id
  subnet_id      = var.subnet-1c
  security_groups = [
    aws_security_group.lighthouse-ci-server-efs-sg.id
  ]
}
