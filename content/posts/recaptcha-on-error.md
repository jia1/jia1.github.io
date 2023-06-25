---
title: "reCaptcha on-error"
date: 2020-11-09T18:20:00+08:00
draft: false
tags: ["angular"]
---
[Polling](/2020/10/polling) wasn't effective because:

1. Hot reloading didn't happen because of some heap limit error.
1. I called the wrong function to check if the reCaptcha errored.

To deal with the heap limit, my buddy suggested updating the `docker-dev` script in `package.json` to:

```json
{
  "scripts": {
    "docker-dev": "export NODE_OPTIONS=\"--max-old-space-size=4096\" && ..."
  }
}
```

As for checking if the reCaptcha errored, neither `on-expire` nor `captchaService.isValid` worked. A possible explanation for the former would be that the reCaptcha didn't expire. It just didn't work. On the other hand, `captchaService.isValid` checks `this.response || !this.enabled`. These don't determine if the reCaptcha errored.

My buddy wondered if there was something like `on-error`. He dug through the reCaptcha package's source code and found it in the [directive](https://github.com/opengovsg/angular-recaptcha-fallback/commit/5896c1096753952aef8ec48f0a4c6c7e5ea8a3d2). This jewel wasn't documented. I proceeded to use `on-error` [with much success](https://github.com/opengovsg/FormSG/pull/582/files)!
