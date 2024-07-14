

resource "aws_iam_user" "admin-user" {
    name = "ram-sre"
    tags = {
        Description = "techSRE"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUserPolicy"
    policy = <<EOF
       {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "ram-admin-access" {
    user = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUser.arn
}