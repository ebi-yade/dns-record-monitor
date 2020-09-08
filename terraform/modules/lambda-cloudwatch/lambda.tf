#####################################
# Lambda
#####################################
resource "aws_lambda_function" "this" {
  function_name = var.lambda_func_name

  handler          = var.handler
  filename         = data.archive_file.function.output_path
  runtime          = var.runtime
  role             = aws_iam_role.this.arn
  source_code_hash = data.archive_file.function.output_base64sha256
  layers           = [aws_lambda_layer_version.this.arn]

  environment {
    variables = var.lambda_env
  }
}
#####################################
# Layer
#####################################
resource "aws_lambda_layer_version" "this" {
  layer_name       = var.lambda_layer_name
  filename         = data.archive_file.layer.output_path
  source_code_hash = data.archive_file.layer.output_base64sha256
}
#####################################
# Lambda Basic Execution Role
#####################################
resource "aws_iam_role" "this" {
  name               = "lambda-basic-${var.suffix_kebab}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  #lifecycle { prevent_destroy = true }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    sid    = "lambdaAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
