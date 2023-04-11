---
title: "Reach Router Match"
date: 2020-12-04T21:10:00+08:00
draft: false
tags: ["react","reach"]
---
I use Reach Router. I have a component which isn't a child of `Router`, so it does not have the `useLocation` hook. But I need to access the current URL in that component. Here's how I did it after seeing [Jacek's hint](https://github.com/reach/router/issues/318):

```html
<div>
  <Match path="/*">
    {(props) => (
      <MyComponent
        path="/*"
        match={props.match ?? ''}
      />
    )}
  </Match>
  <Router>
    ...
  </Router>
</div>
```

```javascript
interface Props {
  match: any;
}

export const MyComponent: FC<Props> = (props: Props) => {
  const pathname = props.match['*'];
  // Do your thing!
};
```

The [official docs](https://reach.tech/router/api/Match) was really brief. I did a `console.log(props.match)` to see what's actually being passed from `Match` to `MyComponent` and found that `'*'` was a key whose value is whatever that comes after the match.

For instance, if we have `<Match path="/blah/*">` and the URL is actually `/blah/a/long/path`, then `props.match['*']` is `a/long/path`.

There are other keys besides `'*'` but I don't need them so it's up to you to explore them yourself!
