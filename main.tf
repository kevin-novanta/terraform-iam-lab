# ==============================
# main.tf — IAM Lab (Terraform)
# ==============================

# 1) IAM Group: Developers
resource "aws_iam_group" "developers" {
  name = var.dev_group_name
}

# 2) Attach AWS managed S3 ReadOnly policy to the group
resource "aws_iam_group_policy_attachment" "s3_readonly" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# 3) IAM User: TestUser
resource "aws_iam_user" "test_user" {
  name          = var.test_user_name
  force_destroy = true # allows cleanup even if user has keys
}

# 4) Add user to Developers group
resource "aws_iam_user_group_membership" "testuser_devs" {
  user   = aws_iam_user.test_user.name
  groups = [aws_iam_group.developers.name]
}

# 5) (Optional) Access key for CLI testing — NOT for production
# Enable by running: terraform apply -var=create_access_key=true
resource "aws_iam_access_key" "test_user_key" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.test_user.name
}

# 6) (Optional) Simple random bucket to test read vs write
resource "random_pet" "suffix" {}

resource "aws_s3_bucket" "test" {
  bucket = "iam-lab-bucket-${random_pet.suffix.id}"
}

resource "aws_s3_object" "seed" {
  bucket  = aws_s3_bucket.test.id
  key     = "seed.txt"
  content = "hello-from-terraform"
}
