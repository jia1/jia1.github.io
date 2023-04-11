---
title: "Polling"
date: 2020-10-05T23:00:00+08:00
draft: false
tags: ["angular"]
---
There were instances where users filled up a time-consuming form but could not submit it because of reCaptcha failure. Users ended up having to refresh and re-populate the form. That's some harsh user experience. My team uses [a forked version of angular-recaptcha](https://github.com/opengovsg/angular-recaptcha-fallback). I located the controller, directive and template for the form. I attached a recursive `$timeout` at the controller and the directive, but as of now, I have not gotten them to work. Some possible questions, which, if answered, may help:

1. Are `$scope` for the controller and `scope` for the directive the right ways to reference the `ng-model="captchaResponse"`?
1. Are the recursive functions placed in the appropriate spots? I first placed them at the bottom of the respective function bodies before moving them up to the top.
1. Are the recursive functions themselves behaving as intended?

Here's the code for my recursive function:

```typescript
(function tick() {
  console.debug($scope.captchaResponse);
  // Do something when captchaResponse is a failure
  $timeout(tick, 1000);
})();
```

Here's the code for the HTML template:

```html
<div
  vc-recaptcha
  ng-model="captchaResponse"
  key="..."
  ng-if="..."
  size="invisible"
  on-create="..."
  on-success="..."
  on-expire="..."
  data-badge="inline"
></div>
```
