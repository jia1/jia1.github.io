---
title: "Iterator to Stream"
date: 2020-11-11T19:38:00+08:00
draft: false
tags: ["java"]
---
With Google Guava, you can transform an `Iterator` into a `Stream` with `Streams.stream(...)`. But that API is only available from Guava 21. If you don't want to use Guava or if your Guava version is below 21, you need an additional step to convert your `Iterator` to a `Stream`:

```java
Stream<String> stream = StreamSupport.stream(
    Spliterators.spliteratorUnknownSize(
        iterator,
        Spliterator.ORDERED
    ),
    false
);
```

Reference: [mkyong](https://mkyong.com/java8/java-8-how-to-convert-iterator-to-stream/).
