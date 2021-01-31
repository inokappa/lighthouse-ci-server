# IAM Role
resource "aws_iam_role" "lighthouse-ci-server" {
  name               = "lighthouse-ci-server"
  assume_role_policy = file("./policies/assume-role.json")
}
 
# IAM Role Policy
resource "aws_iam_role_policy" "lighthouse-ci-server-1" {
  name   = "lighthouse-ci-server-1"
  role   = aws_iam_role.lighthouse-ci-server.name
  policy = file("./policies/policy-1.json")
}

resource "aws_iam_role_policy" "lighthouse-ci-server-2" {
  name   = "lighthouse-ci-server-2"
  role   = aws_iam_role.lighthouse-ci-server.name
  policy = file("./policies/policy-2.json")
}
