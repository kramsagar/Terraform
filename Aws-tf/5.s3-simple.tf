resource "aws_s3_bucket" "finance" {
  bucket = "finanace-july"
  tags = {
    Description = "Finance and payroll"
  }
}

resource "aws_s3_bucket_object" "finance-2024" {
  content = file("/home/rkyasan44/tf/Aws-tf/3.aim-policy-user.tf")
  key = "finance-2024-policy.tf"
  bucket = aws_s3_bucket.finance.id
}