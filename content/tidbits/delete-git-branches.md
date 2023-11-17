---
title: "Deleting all git branches except master"
date: 2023-11-17T15:20:00+08:00
draft: false
tags: ["git"]
---
I like to use different branches to compartmentalise my work items. I don't remember my feature branches, so I list them with `git branch`.

When cleaning them up in my local machine, I often google "delete all branches except master". Today, I want to stop copying commands off the internet. It's not like I don't know these commands - I tuned off and did not bother to break it down.

Today, I want to understand what's happening. Here's the command:

```bash
git branch | grep -v 'master' | xargs git branch -D
```

- The pipe (`|`) passes the output from the previous command to the next as input.
- `grep -v` does an inverse (negative) search.
- `| xargs` converts the output from the previous command into the argument for the next
