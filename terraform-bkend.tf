terraform {
  backend "s3" {
    bucket                   = "terraform-zomato-tfstate"
    key                      = "terraform.tfstate" // location to the key
    region                   = "ap-south-1"
    shared_credentials_files = ["$HOME/.aws/credentials"]
  }
}
