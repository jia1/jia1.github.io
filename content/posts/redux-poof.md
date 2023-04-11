---
title: "Redux Poof!"
date: 2020-10-15T19:00:00+08:00
draft: false
tags: ["redux"]
---
I was at Page A. Page A calls an API and stores the response in the Redux store. After some clicking, I was routed to Page B. I expected to retrieve the API response stored by Page A. But it wasn't there! The culprit was `<a href ...>`. I should be using `Link` or `navigate(...)` instead.

When I refreshed Page B after getting there via `Link`, the store went poof again. To prevent that from happening, I can do the following:

1. Use `redux-persist` and persist Redux stores beyond page loads and refreshes. But that would mean I need to maintain and guarantee freshness.
1. Call the API in Page B too. That does not sit right with me because network calls are expensive. Perhaps I can look into caching API responses with `axios` adapter?

Last but not least, [this is something that I consulted](https://stackoverflow.com/questions/44246856/redux-loses-state-when-navigating-to-another-page). Hope that helps!
