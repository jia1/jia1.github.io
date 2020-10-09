---
title: "First Lighthouse Report for Jiayee.net"
date: 2020-09-19T18:34:00+08:00
draft: false
tags: ["software","web","lighthouse"]
---
I ran my first Lighthouse report on this site. There's a bunch of improvements to make. As of now, I managed to resolve some of them. I put up the links to the before and after Lighthouse reports at the end of this post. Please feel free to take a look at them.

A summary of the improvements I made:

1. Include `lang` attribute to the `html` element i.e. `<html lang="en">`.
1. Added `rel="noopener"` to external links.
1. Increase colour contrast between dark turquoise font and white smoke background.
1. Replace the "Read more" link to "Continue reading X" where X is the title of the post.

I may have missed out some stuff since I wrote this post **after** implementing the improvements. My final score is still not perfect. I will need to put more effort into styling if I want to fix "non-sequential headings". I chose `h5` after `h1` because `h2` is too big and `p` is too small.

I ran the Lighthouse report for mobile after generating the reports for desktop. I knew I had to increase the size of the social media icons to make them more fat finger-friendly. I knew this because I had problems tapping on the icon I want. I should be focusing on this problem ASAP.

Lighthouse reports:

1. [Lighthouse report for desktop (before)](/lighthouse01.pdf)
1. [Lighthouse report for desktop (after)](/lighthouse02.pdf)
1. [Lighthouse report for mobile (after)](/lighthouse03.pdf)
