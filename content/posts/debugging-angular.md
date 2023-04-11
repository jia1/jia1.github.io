---
title: "Debugging Angular"
date: 2020-09-14T21:29:00+08:00
draft: false
tags: ["angular"]
---
Something could've happened in the past 2 weeks while I focused on fixing my unit tests. It had been some time since I last did a local deployment. To my surprise, my local deployments in the recent days rendered a blank page with the following error in the JavaScript console:

```bash
Uncaught Error: [$injector:modulerr] Failed to instantiate module FormSG due to:
Error: [$injector:modulerr] Failed to instantiate module forms due to:
Error: [ng:areq] Argument 'directiveFactory' is required
```

My Google-fu was lacking. My teammate helped me find this [relevant Stack Overflow thread](https://stackoverflow.com/questions/42217831/angularjs-error-ngareq-argument-directivefactory-is-required/42218107). Below was how I've been implementing my directives:

```javascript
'use strict';

angular.module('forms').directive('someDirective', someDirectiveFunction);

const someDirectiveFunction = () => {
  ...
};
```

There's no function hoisting. As such, the console was complaining about the non-existence of `someDirectiveFunction`. If I were to remove `'use strict'`, would the `directiveFactory` error be silent?

I could have fixed the code above by moving the function definition above the call to `.directive(...)`, but after seeing that the other existing directives were defined by `function someDirectiveFunction() { ... }`, I decided to follow suit. Now, my code looks like:

```javascript
'use strict';

angular.module('forms').directive('someDirective', someDirectiveFunction);

function someDirectiveFunction() {
  ...
}
```

I'm glad I asked and I'm fortunate to have such patient teammates.
