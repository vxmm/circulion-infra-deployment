resource "aws_s3_bucket" "cl-recipe-bucket-v2" {
  bucket = format("%s-%s", var.input_bucket, var.region)
}

resource "aws_s3_bucket" "cl-recipe-distribution-v2" {
  bucket = format("%s-%s", var.output_bucket, var.region)
}