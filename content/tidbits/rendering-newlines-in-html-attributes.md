---
title: "Rendering newlines in HTML attributes"
date: 2020-09-21T22:41:00+08:00
draft: false
tags: ["angular"]
---
Doing

```html
<textarea placeholder="line1\nline2">
```

won't work, but doing

```html
<textarea placeholder="{{ somethingFromScope }}">
```

where `somethingFromScope` is `line1\nline2` will work as expected!
