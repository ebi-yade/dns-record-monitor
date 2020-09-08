#####################################
# Provider Settings
#####################################
provider "aws" {
  version = "~> 3.0.0"
  region  = var.region
  profile = var.profile
}

#####################################
# Modules
#####################################

module "lambda-cloudwatch" {
  source = "./modules/lambda-cloudwatch"

  func_name         = local.func_name
  lambda_func_name  = "${local.func_name}-${var.suffix_kebab[terraform.workspace]}"
  handler           = local.handler
  runtime           = local.runtime
  layer_name        = local.layer_name
  lambda_layer_name = "${local.layer_name}-${var.suffix_kebab[terraform.workspace]}"
  lambda_env = {
    HOST_NAME       = var.workspace_params[terraform.workspace]["host_name"]
    HOST_PORT       = var.workspace_params[terraform.workspace]["host_port"]
    CONSUMER_KEY    = var.consumer_key
    CONSUMER_SECRET = var.consumer_secret
    ACCESS_KEY      = var.access_key
    ACCESS_SECRET   = var.access_secret
  }
  span = var.workspace_params[terraform.workspace]["span"]

  suffix       = var.suffix[terraform.workspace]
  suffix_kebab = var.suffix_kebab[terraform.workspace]
  tags = {
    Terraform = "true"
    Name      = var.suffix[terraform.workspace]
  }
}
