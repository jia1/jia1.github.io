---
title: "No qualifying bean"
date: 2020-09-17T15:23:00+08:00
draft: true
tags: ["software","java","spring"]
---
In one of my previous posts, I avoided auto-configuring primitives because it would cause the `No qualifying bean` error. Today, I couldn't avoid that anymore. I had to auto-configure a `boolean` so that the consumer of the custom starter can simply enable or disable a feature with a `boolean` config in `application.yml`.

So, how did I resolve this issue? Instead of placing the primitive config in the configuration class, I simply used `@Value("{someKey:someDefault}") final boolean someFlag` in the constructor where the configuration was required.

Before that, I tried attaching just `@Bean` to the getter but it didn't work out. [This article](https://www.logicbig.com/tutorials/spring-framework/spring-core/inject-bean-by-name.html) helped me demystify `@Bean` and `@Qualifier`, even if just a little.
