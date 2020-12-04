---
title: "Numerical IDs in MongoDB"
date: 2020-12-04T20:27:00+08:00
draft: false
tags: ["software","java","spring","mongo"]
---
Auto-generated IDs in MongoDB are "strange" strings. I quote "strange" because they are actually [derived not out of nowhere](https://stackoverflow.com/questions/5817795/how-are-mongodbs-objectids-generated) despite looking like they had nothing to do with anything. But to users, these IDs are strange.

I had a collection of documents with a `name` property. Originally, `name` was annotated with `@Id`. But it meant that I could not change the value of `name`. `name` was also annotated with regex validation (`@Pattern(...)`) so that I do not have to deal with URL-unsafe characters. That meant that `name` can no longer be a phrase like "My new document". To users, "My new document" is definitely more readable than "MyNewDocument".

I wanted `name` to be mutable and be of any string. As such, `name` can no longer be annotated with `@Id` and `@Pattern`. I don't want to URL-encode and URL-decode strings. Since I no longer want the `name` property of my documents to be `@Id`, I needed an alternative ID that is still presentable. While relational databases like MySQL offer that automatically, [it isn't the case with MongoDB](https://stackoverflow.com/questions/38084238/mongodb-second-id-field-with-auto-increment).

I went on to create a counter collection. It was a pain because I managed to break the counting with various scenarios under the sun. What happens if either counter collection, target collection or both collections are missing?

One of the first things that came to mind was to find a way to intercept insert and save calls. I did not want to modify the controller because ID generation and management ought to be the repository's responsibility. At first, I googled how I could override `MongoRepository` methods. I came across various answers, [one of which mentioned interface composition](https://medium.com/clarityai-engineering/overriding-default-methods-of-spring-mongorepository-e7ca6a637132). It seemed complex, so I did not pursue it. I then stumbled upon [another answer talked about "lifecycle events"](https://stackoverflow.com/questions/43648479/change-or-override-default-behavior-of-mongorepository-savedocument). SGTM.

I referred to the [official docs](https://docs.spring.io/spring-data/mongodb/docs/current/reference/html/#mongodb.mapping-usage.events) and built my lifecycle method. I overrode `onBeforeSave`, but my newly-created documents still did not have their IDs. So glad that [someone else encountered this issue too](https://stackoverflow.com/questions/49536371/onbeforesave-gets-called-but-nothing-happens) and I switched to overriding `onBeforeConvert`. Everything works now.

```java
package blah;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.mapping.event.AbstractMongoEventListener;
import org.springframework.data.mongodb.core.mapping.event.BeforeConvertEvent;

import your models and repositories;

import java.util.Optional;

@Configuration
public class MyModelRepositoryInterceptor extends AbstractMongoEventListener<MyModel> {
    // Inject your repositories here

    @Override
    public void onBeforeConvert(BeforeConvertEvent<MyModel> event) {
        final MyModel myModel = event.getSource();
        if (myModel.getId() == null) { // If ID is null (e.g. create)
            final Optional<MyCounter> myCounterOptional = myCounterRepository
                .findById("anything that differentiates your model from the rest");
            if (myCounterOptional.isPresent()) { // ID counter for MyModel exists, use it.
                final MyCounter myCounter = myCounterOptional.get();
                myCounter.setLastID(myCounter.getLastID() + 1); // Update new last ID
                myCounterRepository.save(myCounter);
                myModel.setId(myCounter.getLastID());
                // No need to call myModelRepository.save here because we are intercepting this very call.
                // myModelRepository.save will execute after this function returns.
            } else { // No ID counter for MyModel, make one
                final long lastID = myModelRepository.count() > 0 // If collection is empty or does not exist
                    ? (myModelRepository.findTopByOrderByIdDesc().getId() + 1) // Get document with largest ID and add 1 to it.
                    : 1L; // Starting from 1 makes more sense outside of SWE.
                // Perhaps I should have used .save instead, but .insert worked for me too.
                myCounterRepository.insert(MyCounter.builder()
                        .id("anything that differentiates your model from the rest")
                        .lastID(lastID)
                        .build());
                myModel.setId(lastID);
            }
        }
        // If ID is not null (e.g. read one, update, delete), we don't have to count any IDs.
    }
}
```

As for how I got `findTopByOrderByIdDesc`, I didn't manage to construct it by myself via the query method auto-complete feature in my IDE. I found the answer on [Stack Overflow](https://stackoverflow.com/questions/38716936/get-last-created-document-in-mongodb-using-spring-data-repository).
