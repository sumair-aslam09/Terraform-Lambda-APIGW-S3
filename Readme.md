Part-1 Execution without API_GATEWAY
-------------------------------------
$terraform apply

Since we don't have API Gateway just yet, let's invoke this function with the aws lambda invoke-command.
$aws lambda invoke --region=ap-south-1 --function-name=hello response.json
Output:
------
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
---------------------------------
If you print the response, you should see the message Hello World!
$cat response.json
{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"message\":\"Hello, World!\"}"}

///////////////////////////////////////////////////////////////////////////////////////
Part-2 With API GATEWAY 
-----------------------------------
Terraform apply 
hello_base_url = "https://vr.ap-south-1.amazonaws.com/dev"

Test HTTP GET method first, append the hello endpoint and optionally provide the URL parameter.
curl "https://<id>.execute-api.us-east-1.amazonaws.com/dev/hello?Name=Anton"

Also, let's test the POST method. In this case, we provide a payload as a JSON object to the same hello endpoint.
curl -X POST \
-H "Content-Type: application/json" \
-d '{"name":"Anton"}' \
"https://<id>.execute-api.us-east-1.amazonaws.com/dev/hello"

//////////////////////////////////////////////////////////////////////////////////////////

Part-3
----------------
Install them to get package.json file
$npm init 
$npm install aws-sdk

$chmod +x terraform.sh
$ ./terraform.sh

We can invoke this new s3 function and provide a json payload with the bucket name and the object.
aws lambda invoke \
 --region=us-east-1 \
 --function-names=s3 \
 --cli-binary-format raw-in-base64-out \
 --payload '{"bucket":"output-bucket-name","object":"hello.json"}' \
 response.json

 $cat respo
