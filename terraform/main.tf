#####################################
# Provider Settings
#####################################
provider "aws" {
  version = "~> 3.0.0"
  region  = var.region
  profile = var.profile
}

