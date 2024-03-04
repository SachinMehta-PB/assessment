terraform {
  backend "s3" {
    bucket = "stateassess"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}