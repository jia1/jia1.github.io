---
title: "Constants"
date: 2020-10-19T22:30:00+08:00
draft: false
tags: ["software","javascript"]
---
I thought consolidating constants was evil. Just two or three dozens of them were enough to become a huge headache for me. In Java, [this practice is frowned upon](https://stackoverflow.com/questions/66066/what-is-the-best-way-to-implement-constants-in-java). In JavaScript, [it seemed alright](https://stackoverflow.com/questions/8595509/how-do-you-share-constants-in-nodejs-modules).

The answer which received the bounty recommended the following:

```javascript
// Warning: This answer was written in 2014.
module.exports = Object.freeze({
  MY_CONSTANT: 'some value',
  ANOTHER_CONSTANT: 'another value'
});
```

It was my first time encountering `Object.freeze`, so I went to google for [the difference between `Object.freeze` and `const`](https://stackoverflow.com/questions/33124058/object-freeze-vs-const). TL;DR: `Object.freeze` prevents further writing to the keys and their values (with exceptions). Nested keys are exempt from this.

If you [scroll a little further down](https://stackoverflow.com/a/39398990) the thread about sharing JavaScript constants, you will see:

```javascript
const FOO = 'bar';

module.exports = {
  FOO
}
```

That led to my final answer:

```javascript
export const TOTAL_MONTHS_PER_YEAR = 12;

// import { TOTAL_MONTHS_PER_YEAR } from './constants';
```

This method of managing constants is not reviewed by my team yet. Will keep you posted, but it will be some time before I request for another review...
