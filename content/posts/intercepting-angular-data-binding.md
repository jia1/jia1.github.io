---
title: "Intercepting Angular Data Binding"
date: 2020-09-23T21:40:00+08:00
draft: false
tags: ["angular"]
---
I've two form switches. Let's call them A and B. I had to program them such that:

1. When A is off, disable and switch B off.
1. When A is on, disable and switch B off.

We can ignore backend logic because I programmed it such that if A is off, ignore B.

So, how did I solve this? I intercepted the data binding with a directive. This may not be the best solution, but it was so convenient and intuitive to me! The directive was a sweet spot:

1. Whenever A changes, I need to check A. If A is off, force B to be off.
1. The checks can't happen at the controller or model because it'd be too "late".
1. I can't do much at the view because I imported the switches from a library which handled `onClick`.
1. I also needed to call the toast service when A is off. I can put this call in the directive (along with the many other things I may need in the future).

Below are some code snippets to illustrate what I did:

Directive:

```javascript
angular
  .module('forms')
  .directive('saveInterceptor', [
    'ToastService',
    saveInterceptor,
  ])

function saveInterceptor(ToastService) {
  return {
    require: 'ngModel',
    link: (scope, elem, attr, ngModel) => {
      ngModel.$parsers.push((inputValue) => {
        if (!inputValue) { // If A is off
          ToastService.show(
            'Some message.',
          )
        }
        scope.B = false // Switch B off whenever A changes
        return inputValue // Do not mutate A
      })
    },
  }
}
```

I had to insert `require('relative path to directive file')` into `main.js`. And, as mentioned in an earlier post about hoisting, `saveInterceptor` must be defined as `function saveInterceptor(ToastService) { ... }` instead of an arrow function. This is because the `.directive(...)` is above the function definition. As such, we need the function hoisting from the `function` keyword.

View:

```html
<input
  type="checkbox"
  ng-model="A"
  save-interceptor
/>
```

Before I end my post, I want to highlight another thing I learnt from this task. It's the difference between `$parsers` and `$formatters`. I got to know about the directive's syntax from this [Stack Overflow thread](https://stackoverflow.com/questions/19969740/how-to-intercept-value-binding-by-ng-model-directive). Both `$formatters` and `$parsers` were present, and, being curious, I went ahead and [looked them up](https://stackoverflow.com/questions/22841225/ngmodel-formatters-and-parsers).

TL;DR: Formatters are for appearances (model -> view); parsers are for saves (view -> model). In our case, we want the parser. This is because user interactions toggle A and B at the view, and we want to watch what the view is passing to the model.
