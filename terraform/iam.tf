# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "LambdaPolicy",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "AppSyncPolicy",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "appsync.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


#Create lambda policy to restrict to one dynamodb table for only PUTs, GETs, and UPDATEs
resource "aws_iam_policy" "GetUpdateVisitorsPolicy" {
  name        = "GetUpdateVisitorsPolicy"
  description = "GetUpdateVisitorsPolicy"

  policy = <<POL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "GetUpdateVisitorsPolicy",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:UpdateItem"
            ],
            "Resource": "arn:aws:dynamodb:${data.aws_ssm_parameter.my_region.value}:${data.aws_ssm_parameter.account_id.value}:table/${data.aws_ssm_parameter.dynamodb_table.value}"
        },
   {
           "Sid": "ParameterStorePolicy",
           "Effect": "Allow",
           "Action": [
               "kms:Decrypt",
               "ssm:GetParameter"
           ],
           "Resource": [
               "arn:aws:ssm:*:${data.aws_ssm_parameter.account_id.value}:parameter/*",
               "arn:aws:kms:${data.aws_ssm_parameter.my_region.value}:${data.aws_ssm_parameter.account_id.value}:key/${data.aws_ssm_parameter.kms_key.value}"
           ]
       },
        {
            "Sid": "LambdaPolicy",
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": "arn:aws:lambda:${data.aws_ssm_parameter.my_region.value}:${data.aws_ssm_parameter.account_id.value}:function:${data.aws_ssm_parameter.lambda_function_name.value}"
        }
    ]
}
POL
}

#Attach Lambda policy to role for Lambda function call
resource "aws_iam_role_policy_attachment" "lambda-role-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.GetUpdateVisitorsPolicy.arn
}
