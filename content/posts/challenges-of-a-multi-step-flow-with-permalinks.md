---
title: "Challenges of a multi-step flow with permalinks"
date: 2020-10-07T22:50:00+08:00
draft: false
tags: ["react"]
---
I decided to invest my time into covering the edge cases that were not handled by Design \#1. Refer to [yesterday's post](/2020/10/multi-step-forms) for the context. The edge cases are:

1. Forms which need data from the preceding forms
1. Dynamic form links

I can deal with the first pain point by leveraging query parameters. A persistent Redux store is not needed (yet). A persistent Redux store is one which persists between page loads and refreshes.

On the other hand, building dynamic form links for step navigation is still a huge headache for me.

This is how you configure `MultiStepFormPageTemplate` in the routing configuration file:

```typescript
// Warning: I wrote these lines without any help from the compiler.
const stepLinks = [
  [PageComponent1, '/path1'],
  [PageComponent2, '/path1/:param1'],
  [PageComponent3, '/path1/:param1/path2'],
  [PageComponent4, '/path1/:param1/path2/path3'],
  [PageComponent5, '/path1/:param1/path4/:param2'],
];
return (
  {stepLinks && stepLinks.map(([component, stepLink], stepNumber) => {
    return (
      <MultiStepFormPageTemplate
        path={stepLink} // A Reach router prop
        stepPage={component}
        stepNumber={stepNumber}
        stepLinks={stepLinks}
      />
    );
  })}
);
```

You should have noticed stuff like `:param1` and `:param2`. These are dynamic at runtime and can change based on user interaction. It isn't possible to retrieve the preceding link (also known as a [HTTP referer](https://en.wikipedia.org/wiki/HTTP_referer)) (e.g. navigating from `/path1/:param1/path2/:param2` to `/path1/:param1`) without hardcoding knowledge about the current link (e.g. `/path1/:param1/path2/:param2`). As such, I will need to either:

1. Store the referer in a persistent Redux store. I may need to investigate Redux middlewares to do this.
1. Move `:param1` and `:param2` to query parameters. Then, access the query string with Reach router's `useLocation().search`. However, there are existing links which have `:param1` and `:param2`. I don't want to break existing implementations.

It seems I don't have much a choice other than investigating Redux middlewares to make Redux storage persistent so that I can store the referers. If I can persist the Redux storage, I would want to cache the user's input from the previous forms as well so that he/she can navigate to a form containing his/her recent response.

These concerns look like things that a multi-step form library should have covered. Unfortunately, frontend components are not obliged to provide out-of-the-box state management.

The multi-step component libraries I know of in the wild are not suitable. They compel me to conduct an overhaul and/or major copypasta of the current codebase. For instance, the libraries can come with their own frontend components. Users will need to reorganise the form into a JSON object. I used one a few years ago, for a closed source codebase. It was crazy - bulky and many LoC.

I don't want to give up.

There isn't much development to `MultiStepFormPageTemplate`. I created an additional prop interface and preserved query parameters. Here's the code:

```typescript
import React, { FC } from 'react';
import { navigate, RouteComponentProps, useLocation } from '@reach/router';

// Form component props must extend from HasRedirectOnSubmit
export interface HasRedirectOnSubmit extends RouteComponentProps {
    nextStepLink?: string;
}

interface Props extends RouteComponentProps {
    stepPage: FC<HasRedirectOnSubmit>;
    stepNumber: number;
    stepLinks: string[];
}

const hasPrevStep = (stepNumber: number) => {
    return stepNumber > 0;
};

const hasNextStep = (stepNumber: number, steps: string[]) => {
    return stepNumber < steps.length - 1;
};

const getNextStepLink = (stepNumber: number, steps: string[]) => {
    if (hasNextStep(stepNumber, steps)) {
        return steps[stepNumber + 1];
    }
    return '';
};

const goToStep = (stepLink: string) => {
    return async (e: { preventDefault: () => void }) => {
        if (stepLink) {
            await navigate(stepLink);
        }
    };
};

export const MultiStepFormPageTemplate: FC<Props> = (props: Props) => {
    // These lines preserve the query params.
    const queryString = useLocation().search;
    const previousStepLink = props.stepLinks[props.stepNumber - 1] + queryString;
    const nextStepLink = getNextStepLink(props.stepNumber, props.stepLinks) + queryString;
    return (
        <div className="multi-step-form">
            <div className="progress-bar"></div>
            <div className="form-page">
                <props.stepPage nextStepLink={nextStepLink} />
            </div>
            <div className="step-navigation">
                <div className={hasPrevStep(props.stepNumber) ? 'show' : 'hide'}>
                    <button onClick={goToStep(previousStepLink)}>
                        Previous
                    </button>
                </div>
                <div className={hasNextStep(props.stepNumber, props.stepLinks) ? 'show' : 'hide'}>
                    <button onClick={goToStep(nextStepLink)}>
                        Next
                    </button>
                </div>
            </div>
        </div>
    );
};
```
