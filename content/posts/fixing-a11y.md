---
title: "Fixing a11y"
date: 2023-07-30T21:44:00+08:00
draft: false
tags: ["css","lighthouse"]
---
I thought I'd need to jump through many hoops to resolve an a11y issue in this site. Today, I realised I didn't need to.

From [my previous Lighthouse reports](/2020/09/first-lighthouse-report-for-jiayee.net/),

`Heading elements are not in a sequentially-descending order`

had been a thorn in the flesh. I didn't want to override the original styles of the headers. But I wanted my `h2` to look like `h3`. I wanted my `h3` to look like `h5`. And I wanted some `p` to look like `h5`.

To make a header look like another, do something like:

```html
<!-- Typescale -->
<h2 class="h3">Hello, I'm Jiayee.</h2>
```

To make a paragraph larger, do:

```html
<!-- Lead Paragraph -->
<p class="lead">{{ .Site.Params.subtitle }}</p>
```

For more information, check out [Foundation's docs](https://get.foundation/sites/docs/typography-helpers.html).

[Lighthouse report for desktop](/lighthouse04.pdf)

Making everything 100 and doing the manual checks are next!
