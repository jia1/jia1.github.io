---
title: "Quick Go 1"
date: 2020-09-28T22:43:00+08:00
draft: false
tags: ["braindump","go"]
---
It was a busy weekend for me. Last Saturday, I went out to catch up with my friends, and I went shopping for an ebook reader. Last Sunday, I cycled with my in-laws and played computer games. On both days, I travelled by public transport, so a couple of hours went into travelling too. Over the weekend, I also had to set up my ebook reader. Besides my HumbleBundle books, I borrowed some books from NLB via OverDrive.

One of my HumbleBundle books was about Go. Since Hugo is my static site generator, it'd be good to learn Hugo's concepts, styles and syntax. I hope I can remember to add the "Powered by Hugo" statement above/below the copyright soon)

Here's one of my `.go` files:

```go
// Chapter 1: My first program
package main

import "fmt"

func main() {
 fmt.Println("1 + 1 =", 1.0 + 1)
 fmt.Println(len("Hello, world!"))
 fmt.Println("Hello, world!"[1]) // prints 101, which represents 5 in binary, instead of 'e'
 fmt.Println("Hello, " + "world!")
 fmt.Println(true && !(true || false))
}

// Chapter 2: Types
// int8 up to int64
// uint8 up to uint64

// byte = uint8
// rune = int32
// 1 byte = 8 bits
// 1 kb = 1024 bytes
// 1 mb = 1024 kb

// uint, int and uintptr sizes are machine-dependent (use int)
// There are other values such as NaN, +infinity and -infinity
// float32 and float64 (use float64)
// complex64 and complex128

// Double-quoted strings cannot contain newlines but allow special escape sequences
// i.e. \n gets replaced with a real newline
// Backtick strings are useable
```

I'm also reading about design patterns in the context of JavaScript and jQuery. There's so much to read, and I'm so glad I purchased this ebook reader. I can finally avoid the glare I've been getting from my usual screens!
