locals {
  func_name  = "dns-record-monitor"
  handler    = "lambda_function.lambda_handler"
  runtime    = "python3.8"
  layer_name = "twitter"
}
