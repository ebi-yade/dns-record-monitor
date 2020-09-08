#####################################
# CloudWatch Logs
#####################################
resource "aws_cloudwatch_log_group" "lambdaInvoke" {
  name = "/aws/lambda/${var.lambda_func_name}"
}
#####################################
# CloudWatchEvent
#####################################

resource "aws_cloudwatch_event_rule" "this" {
  name                = "lambda-${var.lambda_func_name}"
  schedule_expression = "cron(* */${var.span} * * ? *)"
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "lambda-${var.lambda_func_name}"
  arn       = aws_lambda_function.this.arn
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
