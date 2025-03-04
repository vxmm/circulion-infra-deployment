output "lambda_arn" {
  value = aws_lambda_function.cf-lambda-processor-2.arn
}

output "lambda_name" {
  value = aws_lambda_function.cf-lambda-processor-2.function_name
}