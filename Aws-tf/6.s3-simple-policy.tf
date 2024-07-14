resource "aws_s3_bucket" "finance1" {
  bucket = "finanace-july1"
  tags = {
    Description = "Finance and payroll"
  }
}

resource "aws_s3_bucket_object" "finance-20241" {
  content = file("/home/rkyasan44/tf/Aws-tf/3.aim-policy-user.tf")
  key = "finance-20241-policy.tf"
  bucket = aws_s3_bucket.finance1.id
}

data "aws_iam_group" "finanance-data" {
  group_name = "finanance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.finance1.id}/*",
      "Principal": {
        "AWS": [
          "${data.aws_iam_group.finanance-data.arn}"
        ]
      }
    }
  ]
}
EOF
}
