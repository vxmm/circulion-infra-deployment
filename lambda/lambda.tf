resource "aws_lambda_function" "cf-lambda-processor-2" {
  filename      = var.lambda_zip_file
  function_name = "lambda_function"
  role          = var.iam_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.13"
  timeout       = 20
}