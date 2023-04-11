---
title: "String.format equivalent in TypeScript"
date: 2020-10-07T22:50:00+08:00
draft: false
tags: ["javascript"]
---
While working on a problem during work, I thought I needed a way to do a `String.format` equivalent operation in TypeScript (it turns out I didn't need to). I didn't want to install Lodash (50 kB for `_.template` alone) or sprintf (40 kB), so I came up with the following:

```typescript
// Warning: Untested code
export const compileTemplate = (template: string, values: Map<string, string>) => {
    const variables = Array.from(values.keys()).map(key => ':' + key).join('|');
    return template.replace(
        new RegExp(variables, 'g'),
        (match: string) => values.get(match.substr(1)) ?? match
    );
};
```

There are the Stack Overflow threads I consulted:

- [Can ES6 template literals be substituted at runtime (or reused)?](https://stackoverflow.com/questions/30003353/can-es6-template-literals-be-substituted-at-runtime-or-reused)
- [Defer execution for ES6 Template Literals](https://stackoverflow.com/questions/22607806/defer-execution-for-es6-template-literals)
- [Convert a string to a template string](https://stackoverflow.com/questions/29182244/convert-a-string-to-a-template-string)
- [String.Format in Javascript?](https://stackoverflow.com/questions/6220693/string-format-in-javascript)
- [lodash _.template alternative native](https://stackoverflow.com/questions/43187102/lodash-template-alternative-native)
- [Pass a JS Object as the scope to a JS Template Literal?](https://stackoverflow.com/questions/46433901/pass-a-js-object-as-the-scope-to-a-js-template-literal)
- [How do I destructure all properties into the current scope/closure in ES2015?](https://stackoverflow.com/questions/31907970/how-do-i-destructure-all-properties-into-the-current-scope-closure-in-es2015) (but [MDN does not recommend this approach](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/with))
