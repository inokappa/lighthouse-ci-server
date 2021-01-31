provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "~> 0.12"

  # backend "s3" {
  #   bucket = ""
  #   key    = ".terraform.tfstate"
  #   region = "ap-northeast-1"
  # }
}
