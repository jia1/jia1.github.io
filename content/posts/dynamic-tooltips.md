---
title: "Dynamic Tooltips"
date: 2020-09-25T14:55:00+08:00
draft: false
tags: ["angular"]
---
I had a tooltip for a switch which contained 2 lines of text. The first line of the tooltip shows how users can fill the textarea field nearby. The second line reminds users to meet certain prerequisites before filling the field. My GovTech OSS buddy suggested shortening the tooltip depending on user interaction.

At first, the tooltip looked like:

```html
<i
  class="..."
  uib-tooltip="Here's the one and only static tooltip!"
  tooltip-trigger="'click mouseenter'"
></i>
```

`uib-tooltip` seems to come from [UI Bootstrap](https://angular-ui.github.io/bootstrap/#!#tooltip). Before reading the official docs, I stumbled upon this [Stack Overflow thread](https://stackoverflow.com/questions/42057168/angular-bootstrap-tooltip-dynamic-content). It influenced my solution. I then went on to read the docs to understand the versatility of the framework behind the tooltip.

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
$scope.$watch('the controller property which the textarea ng-model is bound to', (newValue) => {
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

On a side note, before coming up with this solution, I managed to make this work as well, although it was getting hacky:

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

I was hesitant to introduce logic into the view. My buddy also suggested delegating the conditional logic to the controller.
