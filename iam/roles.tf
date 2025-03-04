resource "aws_iam_role" "cl-lambda-processor-role-v2" {
  name = "cl-lambda-processor-role-v2"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#Custom IAM policies are attached here
resource "aws_iam_role_policy_attachment" "lambda-attach-custom-policy" {
  role       = aws_iam_role.cl-lambda-processor-role-v2.name
  policy_arn = aws_iam_policy.cl-lambda-processor-policy-v2.arn
}

# Managed IAM policies are attached here
resource "aws_iam_role_policy_attachment" "lambda-attach-managed-policy" {
  role       = aws_iam_role.cl-lambda-processor-role-v2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}