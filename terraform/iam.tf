resource "aws_iam_role" "app_role_task_execution" {
  name = "${local.tags.name}-ecs_task_execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
  tags = local.tags
  
}


resource "aws_iam_policy" "app_role_task_execution_policy" {
  name        = "${local.tags.name}-ecs_task_execution"
  description = "this policy is going to be attached to task execution role"
  policy = data.aws_iam_policy_document.rds_secret.json
  tags = local.tags

}

resource "aws_iam_role_policy_attachment" "app_role_taskpolicy-attach" {
  role       = aws_iam_role.app_role_task_execution.name
  policy_arn = aws_iam_policy.app_role_task_execution_policy.arn
}



resource "aws_iam_role_policy_attachment" "ecr_pull" {
  role       = aws_iam_role.app_role_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



resource "aws_iam_role" "app_role_task" {

  name = "${local.tags.name}-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
  tags = local.tags


}

