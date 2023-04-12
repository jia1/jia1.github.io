---
title: "Push vs Pull CDN"
date: 2023-04-12T12:46:00+08:00
draft: false
tags: ["devops"]
---
It was only recently that I realised that there was more than one way to update the content that your CDN hosts. Since, to the best of my knowledge, Cloudflare was the closest thing to a CDN, I thought all CDN would work like that. Couldn't be more wrong.

I like that Cloudflare is so hassle-free to set up. [It caches my site upon request + nothing in cache](https://community.cloudflare.com/t/differences-between-cloudflare-and-regular-cdns/156227). There is no need to push any content to Cloudflare by myself. However, it was mysterious to me how updates used to show up almost immediately after deployment. It was only late last night that I had to purge the cache and wait for some time before my updates appeared. The downside was I slept a little later studying this symptom. The upside was I learnt something new.

Of course, I am happy to continue with my current setup though [this article recommended the adoption of a push CDN](https://www.belugacdn.com/push-cdn/) for a site with minimal traffic like mine. There is more to Cloudflare than CDN.
