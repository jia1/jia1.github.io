---
title: "Need an extra whitespace?"
date: 2020-10-15T19:16:00+08:00
draft: false
tags: ["react"]
---
Need an extra whitespace in JSX? Instead of `&nbsp;`, try this:

```html
<span>Hello, </span>
{true
  ? 'world!'
  : 'world!'}
```

Some food for thought [here](https://stackoverflow.com/questions/16951133/when-to-use-nbsp).
