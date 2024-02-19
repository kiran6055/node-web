resource "aws_iam_role" "ecs_task_execution" {
  name = "${local.tags.name}-ecs_task_execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
  tags = local.tags
  
}


resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "${local.tags.name}-ecs_task_execution"
  description = "this policy is going to be attached to task execution role"
  policy = data.aws_iam_policy_document.rds_secret.json
  tags = local.tags

}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}
