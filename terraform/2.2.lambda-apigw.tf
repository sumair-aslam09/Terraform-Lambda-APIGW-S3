#Lambda-APIGW integration
resource "aws_apigatewayv2_integration" "api_lambda_hello" {
    api_id = aws_apigatewayv2_api.main.id
    integration_uri = aws_lambda_function.hello.invoke_arn
    integration_type = "AWS_PROXY"
    integration_method = "POST"
}

#Type of Request pass to Lambda
resource "aws_apigatewayv2_route" "get_hello" {
    api_id = aws_apigatewayv2_api.main.id
    route_key = "GET /hello"
    target = "integrations/${aws_apigatewayv2_integartion.api_lambda_hello.id}"
}

resource "aws_apigatewayv2_route" "post_hello" {
    api_id = aws_apigatewayv2_main.id
    route_key = "POST /hello"
    target = "integrations/${aws_apigatewayv2_integration.api_lambda_hello.id}"
}

#Permissions to invoke lambda function
resource "aws_lambda_permission" "api_lm" {
    statement_id = "AllowExecutionFromAPIGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello.function_name
    principal = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

output "hello_base_url" {
    value = aws_apigatewayv2_stage.dev.invoke_url
}



