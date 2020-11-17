---
title: "Abstract classes and AOP"
date: 2020-11-17T21:30:00+08:00
draft: false
tags: ["software","java","spring","aop"]
---
I wanted to avoid writing boilerplate code for CRUD in Spring Boot. But I failed - I could not make my child aspect get along with my child controller. Before adopting AOP, I had an abstract controller which the child controller inherited. CRUD worked well and I no longer needed to repeat the code for simple CRUD anymore. I was happy.

```java
// MyAbstractController
public abstract class MyAbstractController<T extends UniversalModel> {
    private final ... repository;

    public MyAbstractController(final ... repository) {
        this.repository = repository;
    }

    @GetMapping("/{id}")
    public ResponseEntity<T> info(@PathVariable final String id) {
        return ...;
    }
}

// BlahController
@RequestMapping("/blah")
@RestController
public class BlahController extends MyAbstractController<MyModel> {
    public BlahController(final MyRepository repository) {
        super(repository);
    }
}
```

And so, all seemed well..., until I had to integrate AOP. My ideal aspect was one that could inherit basic functionality from its abstract parent. But [JVM would not allow it](https://stackoverflow.com/questions/42607015/emulate-annotation-inheritance-for-interfaces-and-methods-with-aspectj).

```java
// MyAbstractAspect
@Aspect
@Component
public class MyAbstractAspect<T> {
    public MyAbstractAspect() {
    }

    @Pointcut("...")
    public void shouldIntercept() {
    }

    @AfterReturning(value = "shouldIntercept()")
    public void onExecute(final JoinPoint joinPoint, final ResponseEntity<T> response) {
        ...
    }
}

// MyAspect
@Aspect
@Component
public class MyAspect extends MyAbstractAspect<MyModel> {
    public MyAspect() {
        super();
    }
}
```

In the end, I scrapped the hierarchy. There was no more `MyAbstractAspect` and `MyAspect` contained all the functionality that was needed. Still, I could not get `MyAspect` and my child controller to work together. Tried various pointcut expressions but to no avail. [Someone else seemed to have tried the same thing](https://coderanch.com/t/524963/frameworks/pointcut-method-parent-abstract-class) and it didn't seem to work out well either.

Time was getting short, so I conceded and settled with a generic class which extended `ApplicationEvent`. I wanted to publish events via AOP. And now... another road bump. The listener couldn't listen due to [type erasure](https://spring.io/blog/2015/02/11/better-application-events-in-spring-framework-4-2). As suggested by [a kind soul](https://stackoverflow.com/questions/35883022/spring-generic-application-event-failing-to-reach-destination), I had my application event class implement `ResolvableTypeProvider`, and everything finally fell into place.
