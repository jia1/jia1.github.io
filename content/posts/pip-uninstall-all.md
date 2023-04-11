---
title: "pip uninstall All"
date: 2020-10-28T22:06:00+08:00
draft: false
tags: ["python","cli"]
---
I found a one-liner which can uninstall all `pip` packages:

```bash
pip3 freeze | grep -v "^-e" | xargs sudo pip3 uninstall -y
```

I used to do the following:

```bash
pip3 freeze > reqs.txt
sudo pip3 uninstall -r reqs.txt
```

I didn't realise I could do `pip uninstall -r reqs.txt -y` and get rid of those confirmation questions. And I'm pretty sure I messed up the actual requirements file at least once when adopting this approach.

The one-liner for the two commands (without messing up the real file) is:

```bash
sudo pip3 uninstall -y -r < (pip3 freeze)
```

Many thanks to the [Stack Overflow community](https://stackoverflow.com/questions/11248073/what-is-the-easiest-way-to-remove-all-packages-installed-by-pip).
