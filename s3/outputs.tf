output "s3_bucket_input_arn" {
  value = aws_s3_bucket.cl-recipe-bucket-v2.arn
}

output "s3_bucket_output_arn" {
  value = aws_s3_bucket.cl-recipe-distribution-v2.arn
}

output "cl-recipe-bucket-v2-bucket" {
  value = aws_s3_bucket.cl-recipe-bucket-v2.bucket
}