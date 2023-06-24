---
title: "Don't catch everything"
date: 2023-06-24T23:23:00+08:00
draft: false
tags: ["javascript"]
---
I did a catch when I didn't need to. I defined the catch clause for an API request which should return a rejected Promise upon failure. As a result, the toast which indicated failure did not appear.

In [this commit](https://github.com/opengovsg/FormSG/pull/6087/commits/157c5e8d2e6ad716828aa03865844064f55edc5e), I removed the catch clause.

And in [another commit](https://github.com/opengovsg/FormSG/pull/6087/commits/c40a2d9a64a0bfee75395005a401d9e6a4073e66), I defined what failure is.

While writing about this, I wondered if there could be a better way to express identical requirements. A quick search led me to this [Stack Overflow thread](https://stackoverflow.com/questions/43306623/reject-a-promise-from-then) - `throw` (but not in AngularJS).
