provider "aws" {
    region = "us-east-1"
    access_key="AKIASZVIDJXHGVAB7VP5"
    secret_key="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"
}

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
    name = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUser.arn
}