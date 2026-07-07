# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

## Architecture

Pure HTML5 and CSS3. No JavaScript. No build step. No framework.

### Application Structure
- **index.html** — Single-page portfolio with sections: hero, about, services, courses, books, community, contact, footer
- **style.css** — All styling (~18KB), mobile-first responsive design with breakpoints at 900px, 768px, 600px
- **images/** — Static assets including logo, profile photo, course thumbnails, book covers, and background images
- Pure HTML5 + CSS3, zero JavaScript, zero dependencies

### Content Sections (in order)
1. **Navbar** — Fixed navigation with logo, desktop menu, mobile hamburger menu
2. **Hero** — Welcome banner with tagline and background image
3. **About** — Bio and four role cards (Cloud Consultant, Educator, Content Creator, Founder)
4. **Services** — Three service offerings: DevOps Courses, Books, Consulting Services
5. **Courses** — Grid of 10+ course cards linking to Udemy and YouTube
6. **Books** — Three featured books with alternating left-right layout and Amazon links
7. **Community** — Trust badges linking to social platforms, stats section
8. **Contact** — Contact information and quick response message
9. **Footer** — Brand info, navigation links, social links, copyright

### Styling Approach
- **Mobile-first** — Base styles target mobile, media queries add desktop refinements
- **Color scheme** — Yellow (#facc15) accent on dark backgrounds, blue highlights
- **Animations** — Fade-up animations for book rows and stats (CSS keyframes)
- **Layout** — Flexbox and grid for responsive sections, smooth scroll behavior

## Commands 

terraform init
terraform plan
terraform apply

## Conventions

- All infrastructure changes go through Terraform — never modify AWS resources manually
- No JavaScript in this project
- CSS uses mobile-first approach with breakpoints at 900px, 768px, and 600px

## Safety

Never put secrets in this file. No API keys, passwords, or AWS credentials.

