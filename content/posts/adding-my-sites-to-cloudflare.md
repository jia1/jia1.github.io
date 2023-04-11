---
title: "Adding my sites to Cloudflare"
date: 2020-09-13T11:34:00+08:00
draft: false
tags: ["dns"]
---
I added my domains to Cloudflare. Cloudflare offers many cool features that my domain providers do not offer. Well, they did not need to offer those features. In Cloudflare, I get to see features such as:

- Web traffic analytics
- Set up DNSSEC
- Configure network transport options and/or optimisations
- Run speed tests on my site
- Configure caching
- Run JavaScript workers
- Restrict image hotlinking

This list is non-exhaustive. There are more features in the Pro and Enterprise subscriptions. Below are the steps I took to add my domains to Cloudflare.

Steps for Namecheap:

- Login
- Click the "Manage" button to the right of your domain name in the domains table
- In the "Domain" tab, change the "Nameservers" option value from whatever it was to "Custom DNS".
- Do your thing!

Steps for Netim:

- Login
- Click "My Account" at the top right corner
- Click "Domain Services" in the menu on the left-hand side
- Click "Domain Management" when the menu item expands
- Click "Domain name management" in the Overview tab on the right-hand side
- Choose "Nameservers management".
- Select "Custom nameservers".
- Do your thing!

Setting the DNS records (i.e. updating the NS records) did not help. I had to go into the specific configuration or tab for nameservers in each of the domain providers to set them up.
