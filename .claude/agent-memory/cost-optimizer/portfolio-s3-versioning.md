---
name: portfolio-s3-versioning
description: S3 versioning enabled on static site bucket, accumulates old versions from CI/CD deployments causing unnecessary storage costs
metadata:
  type: project
---

**Issue:** S3 versioning is ENABLED on the main site bucket (line 22-28 in main.tf). GitHub Actions deploys on every push to main, and each deployment uploads files, creating new versions of objects that are retained indefinitely.

**Cost Impact:** HIGH
- For a ~5-10MB portfolio site deploying 10-20 times daily = 50-200MB of versioned objects per day
- At $0.023/GB/month for S3 storage = $0.35-1.40/month in extra versioned object storage alone
- Over a year: $4.20-16.80 in unnecessary versioning costs

**Why:** Versioning is useful for disaster recovery on content buckets, but for a static portfolio site that's version-controlled in Git and deployed via CI/CD, old versions serve no purpose.

**How to apply:** 
1. IMMEDIATE: Add lifecycle rule to delete old versions after 7-30 days
2. OPTIONAL: Disable versioning entirely if no rollback requirement exists
