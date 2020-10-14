---
title: "Center"
date: 2020-10-14T18:04:00+08:00
draft: false
tags: ["software","web","css"]
---
Why "Center" instead of "Centre"? Well, that's because "center" is the version used in CSS.

There were moments in my life when I wanted to give up writing in British English. There are so many other people using American English... except for me. Programming languages are expressed using American English as well. I felt like a rebel for naming my variables in British English, but that's what I've learnt in school. It isn't wrong, or is it?

Today, I found myself back in CSS. It isn't good, because I tend to spend a long time prettifying things. In order to adhere to the wireframes, I had to position some elements towards the centre.

Firstly, texts should all be in the centre (horizontally). In the parent `div`, I added this rule:

```css
.parent-div-class {
  text-align: center;
}
```

Secondly, I need to centre a few elements in the vertical plane. In the parent `div`, I added these rules:

```css
.another-parent-div-class {
  display: flex;
  align-items: center;
  min-height: something that works for you;
}
```

Lastly, [this](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) is a lifesaver!
