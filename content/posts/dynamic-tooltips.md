---
title: "Dynamic Tooltips"
date: 2020-09-25T14:55:39+08:00
draft: false
tags: ["software","web","javascript","angular"]
---
I had a tooltip for a switch which contained 2 lines of text. The first line shows an example on how the textarea field below the switch can be populated, like "e.g. example input here". The second line reminds a user that certain prerequisites need to be fulfilled before the textarea field appears and is ready to receive input (hidden otherwise), like "You need to do X before you can populate this field". My GovTech OSS buddy suggested shortening the tooltip when the user has already fulfilled the prerequisites.

The tooltip was initially expressed as:

```html
<i
  class="..."
  uib-tooltip="Here's the one and only static tooltip!"
  tooltip-trigger="'click mouseenter'"
></i>
```

`uib-tooltip` seems to come from [UI Bootstrap](https://angular-ui.github.io/bootstrap/#!#tooltip). Before getting to the official docs, I stumbled upon this [Stack Overflow thread](https://stackoverflow.com/questions/42057168/angular-bootstrap-tooltip-dynamic-content) which influenced my solution. I then went on to read the docs to understand the versatility of this framework.

Here's my solution:

```html
<i
  class="..."
  uib-tooltip-html="myDynamicTooltip"
  tooltip-trigger="'click mouseenter'"
></i>
```

Controller:

```javascript
$scope.$watch('the controller property which the textarea field ng-model is bound to', (newValue) => {
  if (newValue) {
    $scope.myDynamicTooltip = 'Short tooltip';
  } else {
    $scope.myDynamicTooltip = 'Long tooltip';
  }
});
```

The official docs:

```html
<a href="#" uib-tooltip-html="htmlTooltip">scope variable</a>
```

On a side note, prior to this solution, I managed to make this work as well, although getting hacky:

```html
<i
  class="..."
  uib-tooltip-html="'{{ $scope.textAreaInput ? 'Short tooltip' : 'Long tooltip' }}'"
  tooltip-trigger="'click mouseenter'"
></i>
```

The official docs:

```html
<a href="#" uib-tooltip-html="'static. {{dynamicTooltipText}}. <b>bold.</b>'">inline string</a>
```

I was hesitant to introduce logic into the view. My buddy also suggested delegating the conditional logic to the controller after I asked him about this.
