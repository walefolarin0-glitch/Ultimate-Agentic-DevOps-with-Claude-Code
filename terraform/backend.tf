# S3 backend for Terraform state — COMMENTED OUT initially
#
# Follow these steps to enable the S3 backend:
#
# 1. First run: terraform init (without backend configuration)
# 2. Run: terraform apply (to create the initial resources)
# 3. Create an S3 bucket for Terraform state (optional: use the portfolio-site bucket)
# 4. Uncomment the terraform block below
# 5. Run: terraform init -migrate-state (to migrate local state to S3)
#
# If you want to use the portfolio-site bucket itself for state (not recommended for prod):
# - Create a separate object lock table in DynamoDB first
# - Update the bucket and key names below
#
# For production: Create a dedicated state bucket with versioning and encryption enabled

# terraform {
#   backend "s3" {
#     bucket         = "portfolio-site-terraform-state"
#     key            = "production/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
