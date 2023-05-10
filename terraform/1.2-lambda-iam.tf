#aws iam policy generator for lambda 
resource "aws_iam_role" "hello_lambda_exec" {
    name = "hello-lambda"
    assume_role_policy = "${file("../iam-policy/lambda-assume-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "hello_lambda_policy" {
    name = "hello_lambda_policy"
    role = aws_iam_role.hello_lambda_exec.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
