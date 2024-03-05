data "aws_iam_policy_document" "ecs_trust" {

    statement {
      sid = "ECSAssumeRole"
      actions = ["sts:AssumeRole"]
    principals {
        type        = "Service"
        identifiers = ["ecs-tasks.amazonaws.com"]
      }
      
    }
  
}


data "aws_iam_policy_document" "rds_secret" {
  statement {
    sid = "AllowECSTask"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = ["${local.rds_secret_arn}"]
  }

}



data "aws_ssm_parameter" "rds_secret_arn" {
  name = "/timing/vpc/rds_secret_arn"
}



data "aws_ssm_parameter" "app_alb_security_group_id" {
  name = "/timing/vpc/app_alb_security_group_id"
}


data "aws_ssm_parameter" "vpc_id" {
  name = "/timing/vpc/vpc_id"
}


data "aws_ssm_parameter" "rds_end_point" {
  name = "/timing/vpc/rds_end_point"
 
}



data "aws_ssm_parameter" "rds_security_group_id" {
  name = "/timing/vpc/rds_security_group_id"

}


data "aws_ssm_parameter" "ecs_cluster_id" {
  name = "/timing/vpc/ecs_cluster_id"

}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/timing/vpc/private_subnet_ids"
}



data "aws_ssm_parameter" "target_group_arn" {
  name = "/timing/vpc/target_group_arn"
}


