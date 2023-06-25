---
title: "Auto-configuring controllers and repositories"
date: 2020-09-08T21:01:00+08:00
draft: false
tags: ["spring"]
---
I auto-configured Spring Boot REST controllers by adding their names to the `spring.factories` file. On the other hand, I didn't have much luck with auto-configuring Mongo collections (yet).

I then ran the consumer's codebase and used Postman to hit the newly-offered endpoints. Below is the response seen in Postman:

```json
{
  "error": {
    "IllegalArgumentException": "Couldn't find PersistentEntity for type class yourTLD.yourOrg.yourProject.somePackage.SomeModel!"
  }
}
```

I thought the Mongo repository was not auto-configured, so I went to check the consumer's logs.

```bash
Finished Spring Data repository scanning in x ms. Found 1 MongoDB repository interfaces.
Finished Spring Data repository scanning in x ms. Found 1 MongoDB repository interfaces.
Finished Spring Data repository scanning in x ms. Found 2 Reactive MongoDB repository interfaces.
```

I conjectured the first "1 MongoDB repository interfaces" came from the auto-configured repository. When I removed the custom starter from `build.gradle`, there were only logs for 3 repositories. This behaviour supported my hypothesis.

(You may be wondering why there are reactive Mongo repositories. It's because we are transitioning from a reactive codebase to a non-reactive one.)

However, there was no other useful information as the consumer didn't log any errors. The MongoDB provisioner was a massive platform with a ton of logs. I didn't know which one to check and whether I should even check those logs. I proceeded to scrutinise both the consumer and the custom starter's codebases.

This line piqued my curiosity:

```java
@EnableMongoRepositories(value = "yourTLD.yourOrg.yourProject.somePackageContainingRepositories")
```

It didn't point to the custom starter's package containing the auto-configured repository. This could be why I received the `IllegalArgumentException` error.
