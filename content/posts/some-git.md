---
title: "Some Git"
date: 2020-10-27T20:51:00+08:00
draft: false
tags: ["git"]
---
I didn't realise [my pull request](https://github.com/calcsg/core/pull/5) was between branches of the same repository. Not sure if my friend realised. I moved the feature branch's latest updates to my fork's feature branch. I then made [another pull request](https://github.com/calcsg/core/pull/6). I used the following commands to straighten things out:

```bash
# Create a local branch with the same name as the origin remote feature branch
git checkout -b feat/simple-compound-interest-calculators

# Pull in the changes from the origin remote
git pull

# Set the upstream to the origin remote feature branch
git branch --set-upstream-to=origin/feat/simple-compound-interest-calculators feat/simple-compound-interest-calculators

# Check the remotes and their URLs
git remote -v

# Add the remote for my fork
git remote add jiayee git@github.com:jia1/core.git

# Push the pulled changes to my fork
git push jiayee

# Set the upstream to the fork's remote feature branch
git branch --set-upstream-to=jiayee/feat/simple-compound-interest-calculators feat/simple-compound-interest-calculators

# Remove the origin remote feature branch
git push origin --delete feat/simple-compound-interest-calculators
```

I got the following output when I ran the `git remote -v` command:

```bash
origin	git@github.com:calcsg/core.git (fetch)
origin	git@github.com:calcsg/core.git (push)
```

On hindsight, I could have changed the remote for `push`. Then, I wouldn't need to introduce another set of `fetch` and `push` remotes. For the sake of ending this post on a good note, I proceeded to make improvements:

```bash
# Set push origin remote to my fork
git remote set-url --push origin git@github.com:jia1/core.git

# Remove the set of fetch and push remote for my fork
git remote remove jiayee

# Push (no-op) and set the upstream to push origin remote (i.e. my fork)
git push --set-upstream origin feat/simple-compound-interest-calculators
```

My feature branch stopped tracking its remote branch because I removed the remote. That was why I called another `git push`. The `git push` didn't push anything because the remote branch was up-to-date. And, as expected, `git remote -v` looks like:

```bash
origin	git@github.com:calcsg/core.git (fetch)
origin	git@github.com:jia1/core.git (push)
```

Coolio!
