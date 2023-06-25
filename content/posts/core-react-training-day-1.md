---
title: "Core React Training Day 1"
date: 2022-04-26T21:10:00+08:00
draft: false
tags: ["braindump","react"]
---
I'm thankful to be able to attend a React training workshop organised by my company. I have been using React in my job but this workshop made me realise I still have lots to learn.

The exercises were very manageable. I learnt the most from the instructor's detailed explanation of how React works:

- Babel is not part of React but it was helpful to know how Babel makes our lives easier by parsing JSX. I found [a Stack Overflow thread](https://stackoverflow.com/questions/41713966/how-babel-and-jsx-related-or-differ) which describes the relationship between these technologies.
  - I learnt that Babel evaluates `<div>` to a string due to the first letter being a lower-case letter. On the other hand, when we call `React.createElement` with `<App/>` as an argument, Babel will pass the reference to `<App/>` into `React.createElement` since `App` begins with an upper-case letter.

<!-- -->
- I took JSX for granted and thought it was part of React. Other UI libraries use JSX too.
  - I learnt that JSX is syntax sugar for nested function calls. For example: `React.createElement('someDiv', null, React.createElement(...))`. If not for JSX, we would need to have several of such nested function calls to build composable UI.
  - Some JSX attributes are metadata for React and don't go into the HTML code. For example, `onClick`.

<!-- -->
- In OOP, classes are blueprints and objects are instantiated from classes. In React, components are blueprints and elements are "instances" of components. In [this article](https://reactjs.org/blog/2015/12/18/react-components-elements-and-instances.html), there are distinctions between React Components, Elements, and Instances.
  - There is a difference between:
    - `<Button icon={<FaTrash/>}>` (i.e. passing in an element) and
    - `<Button icon={FaTrash}>` (i.e. passing in a component)
  - Depending on the implementation of `Button`, we can refer to the icon as `{icon}` or `<Icon/>`. To make `icon` become `Icon`, use named destructuring of `props`.
  - Passing in components may not be ideal since we don't want to pass its config in as props.
    - `<Button icon={...} iconColor={...}>` contains props applied to components of varying levels of abstraction. It is untidy and we would not have known if `Button` expects us to configure `icon` outside or inside of `Button`.

<!-- -->
- Each child in a list should have a unique `key` prop.
  - I always see this in my console but I didn't bother to figure out why. And I did the one thing which the instructor advised against - setting `key` to be the index of the element in the list.
  - The `key` prop allows React to run a diff on virtual DOMs.
  - When we remove an element in the middle of the list, the indices of the elements are no longer constant. This reduces the performance of the diff function.
  - Random numbers as `key` are not ideal either. Each re-render regenerates the random numbers and these numbers have a small chance of collision.
  - As such, React prefers keys in this order: Good keys, no keys, bad keys.

<!-- -->
- In React, we need to trigger a state change through an event before the DOM gets updated by React.
  - For instance, by clicking on a button like this `<Button onClick={() => setMyState(...)}>`.
  - `const [myState, setMyState] = useState({key1: 'val1', key2: 'val2'});`
    - If we want to use a collection of data (arrays or objects) as the state, do: `setMyState({...myState, yourAffectedKey: newVal})`.
    - We do this because the component gets regenerated along with the brand new state constants when we call `setMyState`.

<!-- -->
- We should memoise slow functions with `useMemo` so that we don't rerun it upon re-render.
  - From [the docs](https://reactjs.org/docs/hooks-reference.html#usememo), the hook accepts a dependency array as its second parameter. The function is re-computed if anything in the dependency array changes.
    - A dependency array is an array which contains variables whose values may change.

<!-- -->
- Hooks are how functional components tap into React's API.

<!-- -->
- There is only one re-render per event loop.
  - If we run multiple `setMyState` in a function, there will only be 1 re-render.
    - This means that subsequent statements in the same function should not expect to retrieve the latest state.

<!-- -->
- [Derived states](https://stackoverflow.com/questions/58288286/what-is-derived-state-in-react-and-why-is-it-important).

<!-- -->
- React hooks must be called in the same order in every component re-render.
  - As such, we cannot put hooks inside conditionals.

<!-- -->
- [useReducer](https://reactjs.org/docs/hooks-reference.html#usereducer)

<!-- -->
- React does not have two-way binding or observables. It works with immutability.
  - To share state between siblings, lift state to the nearest common ancestor.
  - To pass information down through several nodes, consider `useContext` over prop-drilling. `ContextProvider` can provide information to consumers far down the tree.

<!-- -->
- [React Typescript Cheatsheet](https://github.com/typescript-cheatsheets/react)

<!-- -->
- Controlled vs uncontrolled
  - `<input type="type">` = uncontrolled
  - `<input type="type" value="">` = controlled but needs an `onChange` handler
  - `<input type="type" onChange="">` = uncontrolled

<!-- -->
- `e.target.value` is always a string

<!-- -->
- `useRef` allows users to reference the DOM and not cause unintended changes elsewhere

<!-- -->
- The React router matches routes by specificity and not by order.
  - There is no standard for defining query parameters for array of values e.g. `?list=1,2,3` or `?list=1&list=2&list=3` and so on.

<!-- -->
- [React.lazy](https://reactjs.org/docs/react-api.html#reactlazy)
  - `lazy(() => import('./SomeComponent'));` returns an object which could become a component but is not a component yet.
  - Supported by [React.suspense](https://reactjs.org/docs/react-api.html#reactsuspense)
    - If something is not loaded yet, we render the `fallback`.
    - This can help bring down the bundle size.

<!-- -->
- [XHR vs Ajax vs FetchAPI vs Axios](XMLHttpRequest, Ajax, FetchAPI, and Axios)

<!-- -->
- Side effects should go into `useEffect`.
  - List of side effects:
    - Network
    - Local storage
    - Cookies
    - `window`
    - `document`
    - Working on DOM via `refs`

<!-- -->
- [react-hooks/exhaustive-deps](https://stackoverflow.com/questions/58866796/understanding-the-react-hooks-exhaustive-deps-lint-rule)
