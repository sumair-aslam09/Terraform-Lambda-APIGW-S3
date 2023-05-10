resource "aws_iam_role" "s3_lambda_exec" {
    name = "s3-lambda"
    assume_role_policy = "${file("iam-policy/lambda-assume-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "s3_lambda_policy" {
    role = aws_iam_role.s3_lambda_exec.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "test_s3_bucket_access" {
    name = "TestS3BucketAccess"
    policy = "${file("iam-policy/s3-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "s3_lambda_test_s3_bucket_access" {
    role = aws_iam_role.s3_lambda_exec.name
    policy_arn = aws_iam_policy.test_s3_bucket_access.arn
}