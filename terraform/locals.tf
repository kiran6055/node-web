locals {

  tags = {
    name = "timing-app-backend"
    environment = "DEV"
    terraform = "true"
  }


  rds_secret_arn = data.aws_ssm_parameter.rds_secret_arn.value




}

