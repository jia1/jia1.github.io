---
title: "Quick Go 2"
date: 2020-09-30T12:14:00+08:00
draft: false
tags: ["software","go","braindump"]
---
Chapter 3 and 4 were about variables (`var`, `const` and so on) and control structures (`for`, `if` and so on) respectively.

```go
package main

import "fmt"

b := "Hello, world!" // Block scope

func main() {
  // Chapter 3: Variables
  var x string = "Hello, world!"

  var y string
  y = "Hello, world!"

  // x = x + y
  // x += y

  z := "Hello, world!"

  var a = "Hello, world!"

  fmt.Println(b)

  const c = "Hello, world!"

  var (
    d = 1
    e = 2
    f = 3
  )

  var input float64
  fmt.Scanf("%f", &input)
  output := input * 2

  // Chapter 4: Control structures
  i := 1
  for i <= 10 {
    // Do something with i
    i += 1
  }

  for i := 10; i >= 1; i-- {
    // Do something with i
  }

  w = 50
  if w > 100 {
    // Do something
  } else if w > 50 {
    // Do something
  } else {
    // Do something
  }

  // No need to break between cases
  j := 100
  switch j {
    case 0:
      fmt.Println("Zero")
    case 100:
      fmt.Println("Hundred")
    default:
      fmt.Println("Don't know")
  }
}
```
