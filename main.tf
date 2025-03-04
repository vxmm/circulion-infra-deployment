terraform {
  backend "s3" {
    region = "us-east-1"
  }
}

module "iam" {
  source = "./iam"
}

module "lambda" {
  source          = "./lambda"
  iam_role_arn    = module.iam.iam_role_arn
  lambda_zip_file = data.archive_file.lambda.output_path
}

module "s3" {
  source        = "./s3"
  region        = var.region
  input_bucket  = var.input_bucket
  output_bucket = var.output_bucket
}

module "eventbridge" {
  source               = "./eventbridge"
  lambda_function_arn  = module.lambda.lambda_arn
  lambda_function_name = module.lambda.lambda_name
  s3_bucket_name       = module.s3.cl-recipe-bucket-v2-bucket
  s3_bucket_arn        = module.s3.s3_bucket_input_arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "cl-lambda-processor-2.py"
  output_path = "cl-lambda-processor-2-payload.zip"
}