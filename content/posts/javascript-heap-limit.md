---
title: "Javascript heap limit"
date: 2020-10-13T19:11:00+08:00
draft: false
tags: ["javascript"]
---
For the past week, I could not fathom why my diffs seemed to not be on hot reload. It turned out to be a JavaScript heap limit problem. As a result, the codebase did not rebuild and remained stale. This issue does not happen to everyone. I am using a MacBook Air (13-inch, 2017) with 8 GB of RAM.

![JavaScript heap limit](/javascript-heap-limit.png)

Notice the line above the last which says, `FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory`. The fix was to update `package.json` with the following script:

```json
{
  "scripts": {
    "docker-dev": "export NODE_OPTIONS=\"--max-old-space-size=4096\" && npm run build-frontend-dev:watch & ts-node-dev --respawn --transpileOnly --inspect=0.0.0.0 --exit-child -- src/server.ts"
  }
}
```

The script sets the heap size as seen in `export NODE_OPTIONS=\"--max-old-space-size=4096\"` before running the build command. There was no need to change my Docker resource settings.
