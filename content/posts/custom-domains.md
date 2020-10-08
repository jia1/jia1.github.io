---
title: "Custom domains"
date: 2020-09-11T01:10:00+08:00
draft: false
tags: ["software","domains"]
---
A few days ago, I purchased the [`jiayee.net`](https://jiayee.net) domain. Yesterday, I purchased the [`jiay.ee`](https://jiay.ee/blog) domain. It was a novel experience for me. I last "purchased" a domain from Freenom about 3 years ago. Back then, I had the free domain point to my AWS EC2 public IP address (this was for CS3216). This week, my custom domains are pointing towards GitHub pages and Blogger respectively.

For GitHub pages, I followed a guide which is similar to [this one by Rich](https://richpauloo.github.io/2019-11-17-Linking-a-Custom-Domain-to-Github-Pages/).

1. Get a domain.
1. Go to your GitHub pages repository and set the custom domain to the one you just purchased.
1. Go to your domain provider's DNS settings (or your DNS manager, such as Cloudflare) and add the following records:

| Type  | Host | Value           | TTL       |
|:------|:-----|:----------------|:----------|
| A     | @    | 185.199.108.153 | Up to you |
| A     | @    | 185.199.109.153 | Up to you |
| A     | @    | 185.199.110.153 | Up to you |
| A     | @    | 185.199.111.153 | Up to you |
| CNAME | www  | jia1.github.io. | Up to you |

Remember to replace `jia1.github.io.` with your GitHub pages URL. Keep the trailing period as is. Here's [GitHub's official docs](https://docs.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site#about-custom-domain-configuration) if you wish to find out more or verify the correctness of the steps above.

As for Blogspot:

| Type  | Host     | Value           | TTL       |
|:------|:---------|:----------------|:----------|
| CNAME | xxxxxxxx | xxxxxxxx        | Up to you |
| CNAME | www      | ghs.google.com. | Up to you |

Each of the `xxxxxxxx` is a different value and is provided by Blogger. This record containing `xxxxxxxx` helps Blogger verify domain ownership. Here's [Blogger's help page](https://support.google.com/blogger/answer/1233387). Refer to `Step 2: Connect to your non-Google domain from Blogger`.

My next step is to switch to Cloudflare's DNS manager, instead of continuing to manage my domains with the domain providers as the latter's UI are not that ideal (i.e. requiring many clicks just to get to the DNS settings).
