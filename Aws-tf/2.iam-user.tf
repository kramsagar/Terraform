provider "aws" {
    region = "us-east-1"
    access_key="AKIASZVIDJXHGVAB7VP5"
    secret_key="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"
}
resource  "aws_iam_user" "admin-user-ram" {
    name="ram-admin"
    tags = {
        Description = "this is ram user created from tf"
    }
}

resource  "aws_iam_user" "admin-user-ram1" {
    name = each.value
    for_each = var.usernames
    tags = {
        Description = "this is ram user created from tf"
    }
}