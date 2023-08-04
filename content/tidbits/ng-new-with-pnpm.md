---
title: "ng new with pnpm"
date: 2023-08-04T22:14:00:+08:00
draft: false
tags: ["angular"]
---
Many years ago, my friend recommended `yarn` for package management. Things have changed since then. I was searching for a performance comparison report until I stumbled upon `pnpm`.

Then, when I ran `ng new [name]`, `npm` was used. I wanted `pnpm`. I should have done:

```bash
ng new [name] --package-manager pnpm
```

References:
- [Stack Overflow thread](https://stackoverflow.com/questions/52948906/how-do-i-use-pnpm-in-my-angular-project-to-manage-packages)
- [Angular CLI docs](https://angular.io/cli/new)
