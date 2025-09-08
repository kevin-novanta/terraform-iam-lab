# --- S3 bucket details ---
output "bucket_name" {
  description = "Name of the lab S3 bucket"
  value       = aws_s3_bucket.test.bucket
}

output "bucket_arn" {
  description = "ARN of the lab S3 bucket"
  value       = aws_s3_bucket.test.arn
}

# --- Seed object details ---
output "object_key" {
  description = "Key of the seeded object"
  value       = aws_s3_object.seed.key
}

# Virtual-hosted–style URL for the object (region-aware).
output "object_url" {
  description = "Direct HTTPS URL to the seeded object"
  value       = var.aws_region == "us-east-1" ? "https://${aws_s3_bucket.test.bucket}.s3.amazonaws.com/${aws_s3_object.seed.key}" : "https://${aws_s3_bucket.test.bucket}.s3.${var.aws_region}.amazonaws.com/${aws_s3_object.seed.key}"
}

# --- IAM details ---
output "iam_user_arn" {
  description = "ARN of TestUser"
  value       = aws_iam_user.test_user.arn
}

output "developers_group_arn" {
  description = "ARN of the Developers group"
  value       = aws_iam_group.developers.arn
}

# --- Run context sanity checks ---
output "region_used" {
  description = "AWS region used by the provider"
  value       = var.aws_region
}

output "profile_used" {
  description = "AWS profile used by the provider"
  value       = var.aws_profile
}

output "test_user_access_key_id" {
  description = "(Optional) Access key ID for TestUser if created"
  value       = try(aws_iam_access_key.test_user_key[0].id, null)
  sensitive   = true
}

output "test_user_secret_access_key" {
  description = "(Optional) Secret access key for TestUser if created"
  value       = try(aws_iam_access_key.test_user_key[0].secret, null)
  sensitive   = true
}