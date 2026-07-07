---
name: cloudfront-price-class
description: CloudFront configured with PriceClass_200, can downgrade to PriceClass_100 for static site
metadata:
  type: project
---

**Issue:** CloudFront distribution uses PriceClass_200 (line 77 in main.tf), which uses ~99% of edge locations globally.

**Current Cost:** PriceClass_200 = Mid-tier regional pricing
**Recommended:** PriceClass_100 = Budget tier (80% of edge locations, ~25-30% cheaper)

**Cost Impact:** MEDIUM
- PriceClass_100 is ~$0.085 per 10,000 requests vs PriceClass_200 at ~$0.12 per 10,000 requests
- For 100K daily requests (typical portfolio site) = 3M/month = ~$3-4/month savings
- Annual savings: $36-48

**Why:** Portfolio sites don't require global edge coverage. PriceClass_100 covers primary markets (North America, Europe, Asia-Pacific, Australia) — sufficient for most visitors. PriceClass_All (most expensive) includes rare edge locations.

**How to apply:** Change line 77 in terraform/main.tf from `price_class = "PriceClass_200"` to `price_class = "PriceClass_100"`. Re-deploy with terraform apply.
