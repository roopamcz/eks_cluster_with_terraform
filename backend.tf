terraform {
   backend "s3" {
     bucket         = "infra-automation-terraform"
     key            = "nonprod-ri/us-east-1/nonprod-ri.tfstate"
     region         = "us-east-1"
     dynamodb_table = "terraform-locks"
   }
 }