---
title: "Truncating Strings With CSS"
date: 2020-12-04T21:19:00+08:00
draft: false
tags: ["software","css"]
---
A few days ago, I would not have realised truncating strings by number of lines with CSS was possible. I was beginning to sweat when I received a request to truncate strings by number of lines instead of number of characters. To be fair, only SWEs would think of truncating by number of characters instead of line numbers...

My teammate shared an answer he found at [CSS-Tricks](https://css-tricks.com/snippets/css/truncate-string-with-ellipsis/). If I recall, it didn't work out for me because of the way the containers were styled. I had no control over that and I didn't want to control that, so I scoured the internet for more answers.

[Below the accepted answer of this Stack Overflow thread](https://stackoverflow.com/questions/5269713/css-ellipsis-on-second-line) was the answer which worked out for me.

One of the newer comments mentioned that `text-overflow: ellipsis;` wasn't needed anymore. Hurrah! The following worked out for me:

```css
.text-two-lines {
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
```
