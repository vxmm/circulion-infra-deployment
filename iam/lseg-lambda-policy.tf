data "template_file" "cl-lambda-processor-policy-v2" {
  template = file("./iam/lseg-lambda-policy.json.tpl")
  vars = {
    region = var.region
  }
}

resource "aws_iam_policy" "cl-lambda-processor-policy-v2" {
  name   = "cl-lambda-processor-policy-v2"
  policy = data.template_file.cl-lambda-processor-policy-v2.rendered
}