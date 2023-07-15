---
title: "Spring Boot Auto-configuration"
date: 2020-09-07T20:22:00+08:00
draft: false
tags: ["spring"]
---
Every time I use Spring Security, I have to copy and paste a lot of boilerplate code. What if I made the boilerplate code configurable? I decided to venture into this idea.

At first, I extracted only the method body which configures `HttpSecurity`. So I got myself something like a utility library. But this meant there was still some boilerplate code outside of the library. This approach required consumers to define their own configuration classes (annotated with `@Configuration`).

I was unable to write an annotation to guide the creation of such configuration classes. It's because there are [restrictions on the types of annotation members](https://stackoverflow.com/questions/1458535/which-types-can-be-used-for-java-annotation-members).

Giving so much "freedom" to the client offers more room for misunderstanding. As such, I looked into whether I could extract more code into the library. I then stumbled upon [Spring Boot Auto-configuration](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-developing-auto-configuration).

Auto-configuration sounded just like the thing I needed - not a library but a custom starter. Consumers only need to specify their configurations in the `application.yml` file. There is little room for misunderstanding.

First, I annotated my configuration classes with `@Configuration` and `@ConfigurationProperties("someKey")`. Then, I created `src/main/resources/META-INF/spring.factories`. Afterwards, I wrote something like the following into `spring.factories`:

```bash
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
  yourTLD.yourOrg.yourProject.somePackage.SomeConfigClass,\
  yourTLD.yourOrg.yourProject.somePackage.SomeConfigClass2
```

I was more or less done, but there were some things I haven't / won't solve:

1. `No qualifying bean of type String`. I didn't venture into where I should be placing `@Bean`, `@Qualifier` or `@Value`. It's because I didn't want to overwrite my Lombok getters or setters.
1. Including a controller (i.e. annotated with `@RestController`) in the custom starter.
1. Upon the consumer's trigger / API call, interact with the client's database through the controller.
