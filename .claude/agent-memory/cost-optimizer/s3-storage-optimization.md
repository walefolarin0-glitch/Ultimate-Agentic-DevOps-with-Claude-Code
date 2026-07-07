---
name: s3-storage-optimization
description: S3 bucket using STANDARD storage class; should switch to INTELLIGENT_TIERING for cost savings
metadata:
  type: project
---

**Issue:** S3 bucket (line 2-9 in main.tf) uses default STANDARD storage class, which is most expensive tier.

**Current Cost:** STANDARD = $0.023/GB/month
**Recommended:** INTELLIGENT_TIERING = Automatic, ~30-50% cheaper for mixed access patterns

**Cost Impact:** MEDIUM
- For 10GB of site content: $0.23/month (STANDARD) vs $0.12/month (INTELLIGENT_TIERING) = $0.11/month savings
- Annual savings: ~$1.32

**Storage Class Options:**
1. STANDARD (current): Most expensive, best for frequent access
2. INTELLIGENT_TIERING: Automatically transitions between frequent/infrequent tiers (no retrieval fees for HTML/CSS/images served via CloudFront)
3. STANDARD_IA (One-Zone): Cheaper but has retrieval fees (not ideal for high-traffic assets)
4. GLACIER: For archival (not applicable here)

**Why:** Portfolio site assets are accessed through CloudFront, not direct S3. Versioned old objects (from versioning) and infrequently-accessed assets benefit from automatic downgrading to cheaper tiers.

**How to apply:** Add storage_class = "INTELLIGENT_TIERING" to aws_s3_bucket resource in main.tf. Existing objects automatically transition after 30/90 days of inactivity.
