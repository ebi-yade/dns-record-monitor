#####################################
# General
#####################################
variable tags { type = map }

variable suffix {
  type        = string
  description = "suffix for each env"
}
variable suffix_kebab {
  type        = string
  description = "suffix for each env, which has only "
}

#####################################
# Peculiar To This Repo
#####################################

# Lambda Config
variable func_name {}
variable lambda_func_name {}
variable handler {}
variable runtime {}
variable layer_name {}
variable lambda_layer_name {}
variable lambda_env { type = map }

# CloudWatch Events Config
variable span {}
