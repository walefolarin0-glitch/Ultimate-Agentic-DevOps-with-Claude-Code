---
name: terraform-baseline-gaps
description: Recurring security gaps found in terraform/ for the portfolio-site S3+CloudFront stack, as of first audit 2026-07-07
metadata:
  type: project
---

First full audit of `terraform/` (main.tf, variables.tf, outputs.tf, backend.tf, providers.tf) on 2026-07-07 found these gaps. Stack is generated/maintained by the `tf-writer` agent per the project's skill-based workflow — re-check whether these are fixed on each subsequent audit, since tf-writer may regenerate files.

Gaps found (all still open as of 2026-07-07):
- No `aws_s3_bucket_server_side_encryption_configuration` on `aws_s3_bucket.site` — no encryption at rest.
- No `aws_s3_bucket_logging` (access logging) and no CloudFront `logging_config` block — no audit trail.
- No CloudFront `response_headers_policy_id` / custom response headers policy — no CSP, X-Frame-Options, HSTS, X-Content-Type-Options.
- S3 bucket policy (`aws_s3_bucket_policy.site`) has no `aws:SecureTransport` deny statement — doesn't enforce HTTPS-only access to the bucket.
- `backend.tf` has the S3 remote backend entirely commented out — state is local-only, unencrypted, no locking/DynamoDB table active.
- No `.gitignore` exists anywhere in the repo root — `.terraform/` (including the ~large provider binary), `.terraform.lock.hcl`, and any future `terraform.tfstate`/`*.tfvars` are not excluded from git. Git status showed `terraform/` fully untracked (`??`) at time of audit, meaning these artifacts would be committed if `git add .` is run.
- No `aws_s3_bucket_ownership_controls` (BucketOwnerEnforced) alongside the public access block — AWS best practice pairs both.
- S3 bucket name embeds `data.aws_caller_identity.current.account_id` and is re-exposed via `outputs.tf` (`s3_bucket_name`, `s3_bucket_arn`) — low-severity account ID disclosure via a globally-visible bucket name / DNS name.
- No IAM or OIDC resources exist yet in `terraform/` (the GitHub OIDC provider + IAM role described in the root CLAUDE.md architecture section have not been created — presumably pending `/scaffold-cicd`). OIDC trust-policy and least-privilege IAM checklist items are not yet applicable; re-check once `/scaffold-cicd` has run.

What is already done correctly (don't re-flag as new findings, just confirm still present):
- `aws_s3_bucket_public_access_block` present with all four flags true.
- CloudFront uses OAC (not legacy OAI), with the S3 bucket policy scoped via `AWS:SourceArn` condition to this specific distribution.
- `viewer_protocol_policy = "redirect-to-https"` set on the default cache behavior.
- S3 versioning enabled (though no lifecycle rule to expire noncurrent versions — minor storage-cost note, not security).
