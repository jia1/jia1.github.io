---
title: "Quick Go 3"
date: 2020-10-01T21:02:00+08:00
draft: false
tags: ["software","go","braindump"]
---
Chapter 5 and 6 were about basic data structures (like array, slice and map) and functions respectively.

```go
package main

import "fmt"

func main() {
  // Chapter 5: Arrays, slices and maps
  var x [5]int
  x[4] = 100
  fmt.Println(x)

  // No coercing when there is a division operation involving a float64 and int
  // i.e. (mismatched types float64 and int)
  // Should do a / float64(b)

  var total float64 = 0
  for i, value := range x {
    total += value
  }
  // Different from Python's range
  // Compiler will complain "i declared and not used", so we must rename unused variables to '_'

  y := [3]float64{
    1,
    2,
    3,
  }

  // Slice of length 0
  var z []float64
  // Slice of length 5 but is associated with an array of length 10
  a := make([]float64, 5, 10)
  b := x[0:5]
  c := x[:5]
  d := x[0:]
  e := x[:]

  slice := append(y, 8, 9) // [1, 2, 3, 8, 9]
  dst := [1]float64{0}
  copy(slice, dst)
  // dst is now [1]
  // min(len(slice), len(dst)) is copied over

  var g map[string]int // {[key: string]: int}
  g = make(map[string]int)
  // Or just g := make(map[string]int) without the variable declaration
  g["someKey"] = 0
  // delete(g, "someKey")
  lookupResult, lookupSucceeded := g["someKey"]
  if result, ok := g["someKey"]; ok {
    fmt.Printlnt(result, ok)
  }

  h := map[string]string{
    "someKey": "someValue",
  }
  // map[string]map[string]string is a nested map of strings with two levels of keys

  // Chapter 6: Functions
  func average(xs []float64) {
    // panic("To be implemented")
    // Lazy to implement
    return 123, "No error"
  }

  avg, error := average([1]float64{123})

  func add(args ...int) {
    total := 0
    for _, arg := range args {
      total += arg
    }
    return total
  }

  add(1, 2, 3)
  add([]int{1, 2, 3}...)

  // Stopped at Closure
}
```
