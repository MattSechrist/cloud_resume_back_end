variable "backup_bucket_name" {
  type        = string
  default     = ""
  description = "The name of the backup bucket to copy files to main bucket"
  sensitive   = true
}

variable "s3_website_endpoint" {
  type        = string
  default     = ""
  description = "The S3 Website Endpoint URL"
  sensitive   = true
}

variable "cf_origin" {
  type        = string
  default     = ""
  description = "The CloudFront Origin address"
  sensitive   = true
}

#With an HTTP Header having a secret value I can block direct access to my S3 bucket 
variable "http_header" {
  type        = map(string)
  default     = {}
  description = "The custom header name and value for the CloudFront origin."
  sensitive   = true
}

variable "domains" {
  type        = map(string)
  default     = {}
  sensitive   = true
  description = "A map of the main domain name with and without a 'www' prefix"
}

#Buckets variable cannot be marked sensitive in a for_each statement in S3.tf
variable "buckets" {
  type        = map(string)
  default     = {}
  description = "A map of the buckets with and without a 'www' prefix"
}

variable "lambda_function_name" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda function name"

}
variable "lambda_s3_file" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda S3 archive file"
}
variable "lambda_runtime" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda runtime language and version number"
}
variable "lambda_handler" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda function handler"
}
variable "lambda_iam_role" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda IAM role"
}

variable "lambda_event_type" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The Lambda event type"
}

variable "my_region" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The default AWS region for my environment"
}

variable "account_id" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The AWS Account ID"
}

variable "route_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The HTTP API route for my Lambda function"
}

variable "lambda_function_version" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The version number of my Lambda function"
}

variable "dynamodb_table" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The DynamoDB table name"
}

variable "table_item" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The column and value information for my visitor counter table"
}

variable "kms_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The KMS key used to encrypt Parameter Store variables"
}