locals {
  file_path = "../../../../src.zip"
  s3_object_key = "liftstatus/src.zip"
}

resource "aws_s3_object" "api_code" {
  bucket = local.lambda_code_s3_bucket_name
  key    = local.s3_object_key
  source = local.file_path
  source_hash = filemd5(local.file_path)
}

# lambdas
resource "aws_lambda_function" "hello_world" {
  function_name = "hello-world"
  handler = "src.handlers.hello_world.lambda_handler"

  s3_bucket = local.lambda_code_s3_bucket_name
  s3_key = local.s3_object_key

  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = aws_s3_object.api_code.source_hash

  runtime = "python3.12"
}


resource "aws_lambda_function" "lift_status" {
  function_name = "lift-status"
  handler = "src.handlers.lift_status.lambda_handler"

  s3_bucket = local.lambda_code_s3_bucket_name
  s3_key = local.s3_object_key

  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = aws_s3_object.api_code.source_hash

  runtime = "python3.12"
}