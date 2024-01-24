resource "aws_s3_bucket" "lambda_code" {
  bucket = "bish-industries-lambda-code"

  tags = {
    terraform = true
  }
}