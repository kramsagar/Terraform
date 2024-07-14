

resource "aws_iam_user" "admin-user1" {
    name = "ram-sre1"
    tags = {
        Description = "techSRE"
    }
}

resource "aws_iam_policy" "adminUser1" {
    name = "AdminUserPolicy1"
    policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "ram-admin-access1" {
    user = aws_iam_user.admin-user1.name
    policy_arn = aws_iam_policy.adminUser1.arn
}