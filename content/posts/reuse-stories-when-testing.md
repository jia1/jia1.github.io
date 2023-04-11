---
title: "Reuse Stories When Testing"
date: 2023-03-26T21:06:00+08:00
draft: false
tags: ["react","storybook"]
---
My volunteering experience at an open source project led me to appreciate Storybook. Developing frontend components in isolation makes me happy. Unexpected behaviour is localised, and you are appropriately enticed to write your components better. By better, I meant modular. Modularity encourages simplicity (think [SRP](https://en.wikipedia.org/wiki/Single-responsibility_principle)), and this makes code more reusable and self-documenting. There's no greater joy than not having to explain your code.

But wait, there's more: If you think writing stories is exclusive to your Storybook instance and thus a pain to write, think again. You can reuse them when testing. I don't know how I imagined this back then when I had a superficial understanding of Storybook, but I thought it might work. And it does.

This [Medium article](https://medium.com/storybookjs/storybook-%EF%B8%8F-testing-library-f5fd63e106a0) is the guide for reusing stories in tests. The ["Why Storybook?"](https://storybook.js.org/docs/react/get-started/why-storybook) did mention this possibility briefly, but for the concrete steps, watch the video in it.

Since I typically use TypeScript, I had to refer to this [blog post](https://storybook.js.org/blog/writing-stories-in-typescript/). And combined with what we learnt above, we get:

```javascript
// YourComponent.stories.tsx
// Adapted from https://storybook.js.org/blog/writing-stories-in-typescript/
import React from 'react';
import { ComponentStory, ComponentMeta } from '@storybook/react';

export default {
    component: YourComponent,
} as ComponentMeta<typeof YourComponent>;

const Template: ComponentStory<typeof YourComponent> = (args) => (
    <YourComponent {...args} />
);

export const Default = Template.bind({});
Default.args = {
    someArg: 123,
};

// YourComponent.test.tsx
// expect comes from Jest
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Default } from './YourComponent.stories';

describe('YourComponent unit tests', () => {
    test('Default test case', () => {
        render(<Default {...Default.args} />);
        expect(screen.getByText('Some text that should appear in YourComponent')).toBeDefined();
        ...
    });

    ...
});
```
