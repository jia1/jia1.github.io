---
title: "docker system prune -a --volumes"
date: 2020-09-29T21:15:00+08:00
draft: false
tags: ["docker"]
---
I've finally encountered this on my MacBook Air: `no space left on device`. And... `docker system prune -a --volumes` to the rescue! ([Relevant Stack Overflow thread](https://stackoverflow.com/questions/39878939/docker-filling-up-storage-on-macos))
