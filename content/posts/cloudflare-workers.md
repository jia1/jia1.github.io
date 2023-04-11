---
title: "Cloudflare Workers"
date: 2020-09-15T21:31:00+08:00
draft: false
tags: ["dns"]
---
It's time to put my short custom domain to good use. [Cloudflare Workers](https://developers.cloudflare.com/workers/) is a quick 'n' dirty way for me to do URL forwarding. With URL forwarding, I will no longer need to set up DNS records or page rules. The former requires domain verification. Plus, social media websites do not support custom domains (why will they). The latter costs money (the first 3 page rules are free).

My worker's name was `"vanity"` for obvious reasons and it sits at `https://www.jiay.ee/*` and `https://jiay.ee/*`. Without further ado, here's my worker:

```javascript
const defaultPath = 'blog';
const regex = /^(?:https:\/\/)(?:www\.)?(?:jiay\.ee\/)([A-Za-z0-9]+[A-Za-z0-9-_]*[A-Za-z0-9]+)$/i;
const links = {
  [defaultPath]: 'https://jiayee.net',
  fb: 'https://facebook.com/profile.php?id=100001087143682',
  gh: 'https://github.com/jia1',
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const exec = await regex.exec(request.url);
  const path = await exec ? exec[1].toLowerCase() : defaultPath;
  return Response.redirect(links[path] || links[defaultPath], 302);
}
```

So [`jiay.ee/steam`](http://jiay.ee/steam) goes to my Steam profile. Give it a try. Last but not least, if you find your worker still stuck at an old version, clear your browser cache.
