---
title: "No qualifying bean"
date: 2020-09-17T15:23:00+08:00
draft: false
tags: ["spring"]
---
In one of my previous posts, I avoided auto-configuring primitives. Otherwise, the `No qualifying bean` error will occur. Today, I couldn't avoid that anymore. I had to auto-configure a `boolean` so that the consumer can enable or disable a feature in `application.yml`.

So, how did I resolve this issue? I used `@Value("{someKey:someDefault}") final boolean someFlag` in the caller constructor.

Before that, I tried attaching only `@Bean` to the getter, but it didn't work out. [This article](https://www.logicbig.com/tutorials/spring-framework/spring-core/inject-bean-by-name.html) helped me demystify `@Bean` and `@Qualifier`, even if a little.
