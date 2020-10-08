---
title: "My first yarn package"
date: 2020-09-10T23:59:00+08:00
draft: false
tags: ["software","library","javascript"]
---
I wrote my first yarn package (kinda for fun) yesterday. It's strange how I've been consuming packages for the past 2 years but never went to the other side of the table i.e. writing a package. As of now, I haven't published my package but I'm omw. So, how did I create a package? It just felt like the usual... I followed the [yarn docs](https://classic.yarnpkg.com/en/docs/creating-a-package/).

One difference (compared to my usual activities) was I couldn't do `import { ... } from './blah'` and `export const blah = ...`. It's because Babel isn't around to transpile these. At work, webpack was already configured by DevOps and I can do anything that's ES6. Here, I only have myself and it does not make sense to bloat my package with stuff that do not add functionality. And so I stuck with `const blah = require('./blah')` and `module.exports = { blah }`.

Thinking back, I recalled I added `prettier` into the package since I'm a sucker for tidiness. Although `prettier` does not contribute to the functionality of the package, it contributes to my sanity. I'm not sure if I should remove it before release...? Maybe not! However, I really should change these Git hook dependencies to `devDependencies`.

Below are the steps to use `prettier` in your project:

- `yarn add --dev husky lint-staged prettier`
- Insert the following configurations into `package.json`:

```json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged"
    }
  },
  "lint-staged": {
    "**/*": "prettier --write --ignore-unknown"
  }
}
```

`"**/*"` refers to the files to run the script (i.e. `prettier --write ...`) on. If you wish to be more specific, you can have configurations like:

```json
{
  "lint-staged": {
    "*.{css,scss,ts,tsx}": "prettier --write"
  }
}
```

I got to learn about `prettier` from the GovTech FormSG team. I liked this package so much, I introduced it into my projects at Indeed. Bye bye `nit` code review comments!
