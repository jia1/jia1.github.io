---
title: "Style Fixes 1"
date: 2020-09-20T16:26:05+08:00
draft: false
tags: ["software","web","hugo","foundation"]
---
Realised some unexpected styles due to Foundation's default styles, mainly for `<code>` and `<pre>`. The inline code style was fine but the same style was applied to code blocks (i.e. `<pre><code>...</code></pre>`) and that was not fine. There was also insufficient margin and padding for the code blocks. I went to inspect the `<code>` elements and found that Foundation was the one who has been styling the `<code>` elements on top of what Hugo has in store (see [official docs for Syntax Highlighting](https://gohugo.io/content-management/syntax-highlighting/)).

Doing a `code { all: unset; }` was not the way because that would unset stuff that I need, such as `font-family`. I observed the code blocks in my blog posts and implemented the following styles:

```css
$code-font-color: $background-color;

pre {
  margin-bottom: 1em; // Follow Foundation's margin for p
  padding: 1em;
  // Use the following paddings if lineNos = true for [markup][markup.highlight]
  // padding: 1em 0;
  // padding-right: 1em;
}

pre > code {
  background-color: transparent;
  color: $code-font-color;
  border: 0;
  padding: 0;
}
```

I chose `solarized-dark` as the theme for my code blocks (configured in the client's `config.toml`). The list of themes can be found in [Chroma Style Gallery](https://xyproto.github.io/splash/docs/all.html).

In addition to code blocks, I also fixed the background colour for the tables. They were set to be white by Foundation. That's too painful for my eyes.

Last but not least, I've added the "Relevant posts" list below each post in single post view. I'm making progress!
