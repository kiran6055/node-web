locals {

  tags = {
    name = "timing-app-backend"
    environment = "DEV"
    terraform = "true"
  }


  rds_secret_arn            = data.aws_ssm_parameter.rds_secret_arn.value
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  vpc_id                    = data.aws_ssm_parameter.vpc_id.value
  rds_end_point             = split(":",data.aws_ssm_parameter.rds_end_point.value)[0]
  rds_security_group_id     = data.aws_ssm_parameter.rds_security_group_id.value
  ecs_cluster_id            = data.aws_ssm_parameter.ecs_cluster_id.value 
  private_subnet_ids        = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  container_name	    = "app-ecs"
  target_group_arns         = data.aws_ssm_parameter.target_group_arns.value

  target_group = {
     arn = local.target_group_arns
    # Add any other properties you need for the target_group
  }

 env_vars = [
  
  { 
     "name"   : "PORT"
     "value"  : "3000"
  },

  {
 
     "name": "DB",
     "value" : "mydb123" 

  },

  {
     "name"  : "DBUSER",
     "value" : "adminkiran"     

  },

  {
     "name"  : "DBHOST"
     "value" : "${local.rds_end_point}"
  },


  {
     "name"  : "DBPORT"
     "value" : "5432"
  },


  ]


  application_secrets = [
   
   {
      "name" : "DBPASS"
      "valueFrom" : "${local.rds_secret_arn}"

   }

  ]

}



