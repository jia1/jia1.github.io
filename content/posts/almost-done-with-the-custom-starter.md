---
title: "Almost done with the custom starter"
date: 2020-09-09T12:18:00+08:00
draft: true
tags: ["software","library","java","spring"]
---
I was right. I forgot to enable the Mongo repository. And it wasn't only that. I had two Mongo configuration classes. One in the consumer and another in the custom starter. I needed only one. I removed the Mongo configuration class from the custom starter. Then, I enabled the Mongo repository from the custom starter in the consumer's Mongo configuration class. Below is an idea of how my Mongo configuration class looks like:

```java
@EnableMongoRepositories(basePackages = {
        "yourTLD.yourOrg.yourProject.somePackageInConsumerContainingRepositories",
        "yourTLD.yourOrg.yourProject.somePackageInCustomStarterContainingRepositories",
})
public class SomeMongoConfigurationClassInConsumer {
    ...
}
```
