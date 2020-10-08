---
title: "Intercepting Angular Data Binding"
date: 2020-09-23T21:40:56+08:00
draft: false
tags: ["software","web","javascript","angular"]
---
I have two form switches. Let's call them A and B. I was tasked to program them such that:

1. When A is off, B is disabled and off.
1. When A is on, B is enabled but off.

We can safely ignore backend logic because I programmed it such that if A is off, B will be ignored.

So, how did I solve this? I intercepted the data binding with a directive. This may not be the best solution, but it was so convenient and intuitive to me! The directive was a sweet spot:

1. Whenever A changes, I need to check A. If A is off, force B to be off.
1. The checks cannot happen at the controller or model because it'd be too "late".
1. I can't do much at the view because the switches were imported from a library which handled `onClick`.
1. I also needed to call the toast service when A is found to be switched off. I can put this call in the directive (along with many other things I may need in the future).

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
        scope.B = false // B is switched off whenever A changes
        return inputValue // Do not mutate A
      })
    },
  }
}
```

I had to insert `require('relative path to directive file')` into `main.js`. And, as mentioned in an earlier post, `saveInterceptor` must be defined as `function saveInterceptor(ToastService) { ... }` instead of as an arrow function because the `.directive(...)` is above the function definition and we need the function hoisting from the `function` keyword.

View:

```html
<input
  type="checkbox"
  ng-model="vm.A"
  save-interceptor
/>
```

Before I end my post, I want to highlight another thing I learnt from this task. It's the difference between `$parsers` and `$formatters`. I got to know about the directive's syntax from this [Stack Overflow thread](https://stackoverflow.com/questions/19969740/how-to-intercept-value-binding-by-ng-model-directive). Both `$formatters` and `$parsers` were used, so I went ahead and [looked them up](https://stackoverflow.com/questions/22841225/ngmodel-formatters-and-parsers).

TL;DR: Formatters are just for appearances (model -> view) and parsers are for saves (view -> model). In our case, we want the parser because A and B are switches which are toggled from the view, and we want to watch what the view is passing to the model.
