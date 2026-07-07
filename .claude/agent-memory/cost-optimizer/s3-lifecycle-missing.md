---
name: s3-lifecycle-missing
description: No S3 lifecycle policies configured; missing opportunity to auto-clean versioned objects and optimize storage transitions
metadata:
  type: project
---

**Issue:** No aws_s3_bucket_lifecycle_configuration resource defined in main.tf. With versioning enabled, old object versions accumulate indefinitely.

**Cost Impact:** MEDIUM-HIGH (depends on deployment frequency)
- Daily deployments × 30 days = 30 versions of each file retained
- For 500 files in site = 15,000 old object versions accumulating
- At $0.023/GB/month per version = significant unnecessary cost

**Recommended Lifecycle Rules:**

1. **Expire Non-Current Object Versions:** Delete old versions after 7-30 days
   - Saves: $0.35-2/month (depending on deployment frequency)

2. **Transition to Cheaper Storage:** Move old versions to GLACIER (optional, if rollback needed)
   - Saves: ~80% on old object storage

3. **Delete Incomplete Multipart Uploads:** Auto-cleanup after 7 days (orphaned upload chunks)
   - Saves: $0.05-0.20/month (prevents orphaned chunks from accumulating)

**How to apply:** Create aws_s3_bucket_lifecycle_configuration resource with rules:
- NoncurrentVersionExpiration: 14 days (deletes old versions)
- AbortIncompleteMultipartUpload: 7 days (cleans orphaned uploads)
