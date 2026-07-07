---
name: tf-backend-status
description: Terraform state backend currently disabled; when enabled, use separate state bucket to avoid mixing costs
metadata:
  type: project
---

**Issue:** backend.tf (lines 17-25) has S3 backend commented out. Instructions recommend NOT using main portfolio bucket for state (line 12).

**Current State:** Local terraform.tfstate file in working directory (no remote backend).

**Cost Impact:** LOW (for now)
- Local state files have no AWS cost
- But NOT recommended for production/team workflows

**When Backend is Enabled:**

**DO:** Create separate dedicated state bucket
- portfolio-site-terraform-state (separate from portfolio-site-production bucket)
- Encryption: enabled
- Versioning: enabled
- DynamoDB locking table: terraform-locks

**DON'T:** Use main site bucket for state storage
- Reason: State file is sensitive (contains all resource IDs, configurations)
- Reason: Mixing state with content complicates lifecycle rules and invalidation
- Cost: Minimal, but operational complexity high

**Estimated Cost of Dedicated State Backend:**
- S3 backend bucket storage: ~$0.023/month (state file ~1-5MB)
- DynamoDB lock table: ~$1.25/month (on-demand pricing, minimal usage)
- Total: ~$1.30/month

**How to apply:** When ready for team/production use, run /scaffold-terraform to regenerate infrastructure with proper state backend configuration.
