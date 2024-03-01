resource "aws_security_group" "app_ecs" {
  name        = "timing-application-ecs"
  description = "timing-application-ecs"
  vpc_id      = local.vpc_id


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}


resource "aws_security_group_rule" "ingress" {
  type                      = "ingress"  
  security_group_id         = aws_security_group.app_ecs.id
  source_security_group_id  = local.app_alb_security_group_id
  from_port                 = 3000
  protocol                  = "tcp"
  to_port                   = 3000
}



resource "aws_security_group_rule" "rds-sg" {
  type                      = "ingress"
  security_group_id         = local.rds_security_group_id
  description               = "allowing traffic from API ECS on 5432"
  source_security_group_id  = aws_security_group.app_ecs.id
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
}




