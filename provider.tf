provider "aws" {
  region = var.region
  #access_key = var.access_key
  #secret_key = var.secret_key
  shared_credentials_files = ["$HOME/.aws/credentials"]
  default_tags {
    tags = {
      project    = var.project_name
      Enviorment = var.project_env
    }
  }
}
