variable "dev_group_name" {
  description = "Test IAM Dev Group Name"
  type        = string
  default     = "Developers"
}

variable "test_user_name" {
  description = "Test IAM User Name"
  type        = string
  default     = "TestUser"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "admin"
}

variable "create_access_key" {
  description = "IAM Access Key For TestUser"
  type        = bool
  default     = true 
}