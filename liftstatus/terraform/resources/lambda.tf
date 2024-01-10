locals {
  file_path = "../../../../code.zip"
  s3_object_key = "liftstatus/code.zip"
}

resource "aws_s3_object" "api_code" {
  bucket = local.lambda_code_s3_bucket_name
  key    = local.s3_object_key
  source = local.file_path
  source_hash = filemd5(local.file_path)
}

resource "aws_lambda_function" "lift_status" {
  function_name = "lift-status"
  handler = "main.lambda_handler"

  s3_bucket = local.lambda_code_s3_bucket_name
  s3_key = local.s3_object_key

  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = aws_s3_object.api_code.version_id

  runtime = "python3.12"
}



data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}