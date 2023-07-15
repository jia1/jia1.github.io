---
title: "Core React Training Day 2"
date: 2022-04-27T22:00:00+08:00
draft: false
tags: ["braindump","react"]
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
- We can't run `setMyState` on an unmounted component. There can be race conditions where the component can either be mounted or unmounted when we run `useEffect`.

<!-- -->
- `useEffect` can return a cleanup function in the form: return () => {}; ([docs](https://react.dev/reference/react/useEffect#useeffect))

<!-- -->
- There is no built-in API to check if a component is mounted.

```javascript
useEffect(() => {
  // Do API call with courseSlug with .then(course => setCourse(course))
}, [courseSlug]);
// This can lead to race conditions and memory leak.
// If we click rapidly, only the last API call survives.
```

<!-- -->
- So, do it yourself. These are equivalent:

```javascript
// Inside a functional component
useEffect(() => {
  let mounted = true;
  if (mounted) {
    // Set state in API callback
  }
  return () => {
    mounted = false;
  };
}, [courseSlug]);

// Class component
class YourComp {
  let mounted = true;
  // ...
  componentWillUnmount() {
    mounted = false;
  }
}
// Read: https://reacttraining.com/blog/isMounted-tricks-are-code-smell
```

<!-- -->
- `const mountedRef = useRef(true); // synonomous with a mutable state that does not cause re-render`

<!-- -->
- Can you have more than one effect per component? Yes. There is no need to merge effects into one big `useEffect`.

<!-- -->
- Do you need cleanups? Not always.

<!-- -->
- Side effects should run after render phases Which render phases? Not all. We don't want to run side effects on the server (SSR). Running side effects on render phase = any amount of bugs can come ([legacy docs](https://legacy.reactjs.org/docs/hooks-rules.html)).

<!-- -->
- [HoC (pattern) vs Render Props (pattern) vs Hooks (not pattern, a new API)](https://gist.github.com/bradwestfall/4fa683c8f4fcd781a38a8d623bec20e7)

<!-- -->
TBC!
