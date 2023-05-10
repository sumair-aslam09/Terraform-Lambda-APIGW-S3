#convert to zip
data "archive_file" "lambda_s3" {
    type = "zip"

    source_dir = "../${path.module}/s3"
    output_path = "../${path.module}/s3.zip"
}

#lambda function
resource "aws_lambda_function" "s3" {
    function_name = "s3"

    s3_bucket = aws_s3_bucket.lambda_bucket.id
    s3_key = aws_s3_object.lambda_s3.key

    runtime = "nodejs16.x"
    handler = "function.handler"

    source_code_hash = data.archive_file.lambda_s3.output_base64sha256
    role = aws_iam_role.s3_lambda_exec.arn
}

#cloudwatch for function
resource "aws_cloudwatch_log_group" "s3" {
    name = "/aws/lambda/${aws_lambda_function.s3.function_name}"
    retention_in_days = 14
}

#s3 bucket key
resource "aws_s3_object" "lambda_s3" {
    bucket = aws_s3_bucket.lambda_bucket.id

    key = "s3.zip"
    source = data.archive_file.lambda_s3.output_path

    source_hash = filemd5(data.archive_file.lambda_s3.output_path)
}
