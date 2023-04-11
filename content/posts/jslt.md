---
title: "JSLT"
date: 2020-09-29T18:22:00+08:00
draft: false
tags: ["json","jslt"]
---
I have a GraphQL service and a Spring Boot application. The latter consumes the former. In the application, I transform the retrieved JSON with the help of [JSLT](https://github.com/schibsted/jslt). Today, I wrote a JSLT program to do de-duplication and array intersection. Below is the context:

My GraphQL query:

```graphql
query MyQuery(...) {
  arrayA: someModel(...) {
    someInnerModel {
      id
    }
  },
  arrayB: someModel(...) {
    someInnerModel {
      id
    }
  }
}
```

Expected JSON response from GraphQL service:

```json
{
  "data": {
    "arrayA": [
      {
        "someInnerModel": {
          "id": 1
        }
      },
      {
        "someInnerModel": {
          "id": 2
        }
      }
    ],
    "arrayB": [
      {
        "someInnerModel": {
          "id": 1
        }
      },
      {
        "someInnerModel": {
          "id": 3
        }
      }
    ]
  }
}
```

We want the final JSON to look like:

```json
[
  {
    "id": 1
  }
]
```

JSLT has built-in functions but they are very simple ones. At first glance, it may seem impossible to do de-duplication and array intersection. However, it is possible to do these tasks with good knowledge of JavaScript objects. Without further ado, here's my JSLT snippet:

```java
def removeDuplicates(array)
  let object = {for ($array) string(.) : .}
  [for ($object) .value]

def getIntersection(array1, array2)
  let ids1 = (removeDuplicates([for ($array1) .someInnerModel.id]))
  let ids2 = (removeDuplicates([for ($array2) .someInnerModel.id]))
  [for ($ids1) . if (contains(., $ids2))]

let ids = (getIntersection(.data.arrayA, .data.arrayB))
[for ($ids)
{
  "id": .
}]
```

Some notes:
- `{for ($array) string(.) : .}` transforms `[1, 2, 2, 3]` into `{"1": 1, "2": 2, "3": 3}`.
- `[for ($object) .value]` transforms `{"1": 1, "2": 2, "3": 3}` into `[1, 2, 3]`.
- `[for ($array1) .someInnerModel.id]` transforms `[{"someInnerModel":{"id":1}}]` into `[1]`.
- `contains(., $ids2)` returns `true` if the value represented by `.` exists in `$ids2`.
- `[for ($ids1) . if (contains(., $ids2))]` is like Python's list comprehension i.e. `[x for x in range(5) if (x in ids2)]`.
- `getIntersection` does not return elements from `$array1`. It returns elements from `$ids1`.
- I surrounded my variable definitions with parentheses because of this [bug](https://github.com/schibsted/jslt/issues/98).
