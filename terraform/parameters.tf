
data "aws_ssm_parameter" "rds_secret_arn" {
  name = "/timing/vpc/rds_secret_arn"
}

