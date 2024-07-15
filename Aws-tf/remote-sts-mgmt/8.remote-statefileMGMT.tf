resource "local_file" "temp1" {
  filename = "./showme.txt"
  content = "this is remote state file manangement into S3 bucket"
}
provider "aws" {
    region = "us-east-1"
    access_key="AKIA2UC3CS7MZPIDHZHI"
    secret_key="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"
}
