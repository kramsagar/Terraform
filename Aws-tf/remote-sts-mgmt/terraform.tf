terraform {
  backend "s3" {
    bucket = "ram-backend-sts-mgmt-bucket"
    key = "ram-backend-sts-mgmt-object1"
    region = "us-east-1"
    #dynamodb_table = "state-locking"
  }
  
}