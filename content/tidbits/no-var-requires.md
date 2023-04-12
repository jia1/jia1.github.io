---
title: "Rule: no-var-requires"
date: 2020-09-13T22:12:00+08:00
draft: false
tags: ["javascript"]
---
My pre-commit hook complained because the original code had an import that looked like `var module = require("module")`. The permitted ways to import are: `import foo = require('foo')` and "ES2015-style imports" which (I think) is defined in [this part of the MDN web docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). I wonder when this rule was inserted...
