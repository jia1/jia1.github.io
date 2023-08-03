---
title: "for-in and for-of"
date: 2023-08-03T23:37:00+08:00
draft: false
tags: ["javascript"]
---
I needed to [change my async code into synchronous](https://github.com/opengovsg/postmangovsg/pull/2136/commits/301c2aeb425c790a20e29be6e038fabd7719872f). I didn't need to track the index of the array, so I wanted a `for...??` loop.

Was it `for...in` or was it `for...of`!?

<h3 class="h4">for...in</h3>

Example: `for (let key in someObject)`

```javascript
const a = [4,5,6]
const b = [{'k1':'v1'},{'k2':'v2'},{'k3':'v3'}]
const c = {'k1':'v1'}

for (let d in a) { console.log(d) } // 0 1 2
for (let d in b) { console.log(d) } // 0 1 2
for (let d in c) { console.log(d) } // k1
```

<h3 class="h4">for...of</h3>

Example: `for (let value in someIterable)`

```javascript
const a = [4,5,6]
const b = [{'k1':'v1'},{'k2':'v2'},{'k3':'v3'}]
const c = {'k1':'v1'}

for (let d of a) { console.log(d) } // 4 5 6
for (let d of b) { console.log(d) } // {'k1':'v1'} {'k2':'v2'} {'k3':'v3'}
for (let d of c) { console.log(d) } // Uncaught TypeError: c is not iterable
```
