---
title: "Sticky"
date: 2020-11-11T20:43:00+08:00
draft: false
tags: ["css"]
---
I found myself entangled in CSS. I needed `app-header` to stick to the top at all times. I also needed `template-header` to be right beneath `app-header` at all times. Lastly, `embedded-content` should begin immediately after `template-header` and shouldn't be sticky. Here's how the page organisation might look like:

```html
<div class="app">
  <div class="app-header">
    <!-- Content -->
  </div>
  <div class="app-content">
    <div class="template-container">
      <div class="template-header">
        <!-- Content -->
      </div>
      <div class="embedded-content">
        <!-- Content -->
      </div>
    </div>
  </div>
</div>
```

The simplest approach is to place `app-header` and `template-header` inside a single `div`. Then, we will only need to stick one element at the top. However, `app-header` and `app-content` are independent of each other. They are of different scopes in React. Here's my initial approach:

```css
.app-header {
  position: sticky;
  top: 0;
  width: 100vw;
  z-index: 1;
}

.app-content {
  margin-top: 70px;
}

.template-header {
  padding: 2px;
  position: fixed; /* Changing to position: sticky; didn't work for me. */
  top: 56px;
  z-index: 1;
}
```

Having `margin-top: 70px` and `top: 56px` was disturbing. Depending on the viewport, the height of `app-header` changes due to overflow. A quick fix for `top: 56px` is to use media queries. But, I'd want to defer that. The overflow problem may no longer apply when the content in `app-header` gets condensed into something like a hamburger button.

As for `margin-top: 70px`, it becomes a problem when there are pages without `template-container`. They look like:

```html
<div class="app">
  <div class="app-header">
    <!-- Content -->
  </div>
  <div class="app-content">
    <!-- Content -->
  </div>
</div>
```

This poses a problem because `margin-top: 70px` means there will be a space between `app-header` and `app-content`. In a world where CSS can do whatever we want, we can have `app-content` conditionally choose a style based on the presence of `template-container`. But for now, [this ideal approach isn't possible](https://stackoverflow.com/questions/21252551/apply-style-to-parent-if-it-has-child-with-css).

A quick remedy for `margin-top: 70px` is to refactor pages without `template-container` to now have a header of a similar height. Sounds quick but I expect this to be rather tedious.

Update: Changing the `position` value for `template-header` to `sticky` didn't work at first because of the superfluous `margin-top: 70px`. Here's the simplified solution:

```css
.app-header {
  position: sticky;
  top: 0;
  width: 100vw;
  z-index: 1;
}

.template-header {
  padding: 2px;
  position: sticky;
  top: 56px;
  z-index: 1;
}
```

I will sign off this post with [a caniuse lookup](https://caniuse.com/css-sticky).
