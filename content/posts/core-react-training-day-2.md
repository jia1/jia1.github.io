---
title: "Core React Training Day 2"
date: 2022-04-27T22:00:00+08:00
draft: true
tags: ["software","javascript","react"]
---
Day 2 was a continuation of our understanding of the `useEffect` hook. Some of concepts mentioned were concepts I "felt" while getting my hands dirty. The workshop was a conducive environment to make these concepts known to me more.

- Some keywords, libraries or links of interest:
  - `usehooks-ts`
  - `eslint-plugin-react-hooks`
  - [React lifecycle diagrams](https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/)

<!-- -->
- The dependency array in `useEffect` does diffs by identity.
  - For primitives, we diff by value.
  - For objects, we diff by memory location.
    - We need to be careful when placing non-primitives into the dependency array. We risk getting into infinite loops.

<!-- -->
- Ways to get into an infinite loop:
  - Placing `setMyState` into the return (render) value unconditionally. This means we run `setMyState`, change `myState` and trigger re-renders.

<!-- -->
- `useEffect` can offer the functionalities of both `componentDidMount` and `componentDidUpdate` by configuring the dependency array.
  - `useEffect` with a non-vacant dependency array is similar to a `componentDidUpdate` with an if statement checking the state of the dependency.

<!-- -->
- We cannot run `setMyState` on an unmounted component. There can be race conditions where the component can either be mounted or unmounted when we run `useEffect`.
