---
title: "Create React App environment variables"
date: 2023-07-15T14:44:00+08:00
draft: false
tags: ["react"]
---
I worked on React codebases for years. For various reasons, I never had to deal with client-side environment variables.

I was first exposed to the concept of environment variable prefixes in [Next](https://start.open.gov.sg/docs/concepts/env-variables#client-schema).

Unfortunately, it took me a while to realise that this concept was also applicable to [create-react-app](https://create-react-app.dev/docs/adding-custom-environment-variables/).

As a result, I spent some time wondering why my environment variables were not replaced at build time. [I started to think it was because they were replaced during runtime](https://www.digitalocean.com/community/questions/environment-variables-not-working-for-static-site-on-digitalocean-app-platform). I felt silly for believing in everything I read.

My answer is currently under review by the DigitalOcean team.
