#CONVERTS TO ZIP
data "archive_file" "lambda_hello" {
    type = "zip"

    source_dir = "../${path.module}/hello"
    output_path = "../${path.module}/hello.zip"
}

#S3 BUCKET OBJECT KEY
resource "aws_s3_object" "lambda_hello" {
    bucket = aws_s3_bucket.lambda_bucket.id

    key = "hello.zip"
    source = data.archive_file.lambda_hello.output_path
    etag = filemd5(data.archive_file.lambda_hello.output_path)
}

#LAMBDA FUNCTION
resource "aws_lambda_function" "hello" {
    function_name = "hello"

    s3_bucket = aws_s3_bucket.lambda__bucket.id
    s3_key = aws_s3_object.lambda_hello.key

    runtime = "nodejs16.x"
    handler = "index.handler"

    source_code_hash = data.archive_file.lambda_hello.output_base64sha256

    role = aws_iam_role.lambda_role.arn
}

#CLOUD-WATCH LOGS
resource "aws_cloudwatch_log_group" "hello" {
    name = "/aws/lambda/${aws_lambda_function.hello.function_name}"

    retention_in_days = 14
}




