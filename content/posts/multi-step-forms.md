---
title: "Multi-step forms"
date: 2020-10-06T21:48:00+08:00
draft: false
tags: ["software","web","javascript","react"]
---
I have a few pages which I need to chain into a single form flow. I also need to display a progress bar at the top of each form. I need to do some rearchitecting. Reasons:

1. If we do not do anything, we will need to insert `<ProgressBar .../>` and the like into every form component.
1. Sharing the forms/pages across other flows which do not need to progress bar is difficult.
1. The form flow will become more obscure. This is because the flow is not grouped or labelled with anything related to a multi-step form.

I came up with the following two designs:

Design \#1:

```typescript
import React, { FC } from 'react';
import { RouteComponentProps } from '@reach/router';

import './style.css'; // .hide { display: none; }

export interface Props extends RouteComponentProps {
    stepPage: FC;
    stepNumber: number;
    stepLinks: string[];
}

const hasPrevious = (stepNumber: number) => {
    return stepNumber > 0;
};

const hasNext = (stepNumber: number, steps: string[]) => {
    return stepNumber < steps.length - 1;
};

export const MultiStepFormPageTemplate: FC<Props> = (props: Props) => {
    return (
        <div className="multi-step-form">
            <div className="progress-bar"></div>
            <div className="form-page">
                <props.stepPage />
            </div>
            <div className="step-navigation">
                <div className={hasPrevious(props.stepNumber) ? 'show' : 'hide'}>
                    // Insert button here
                </div>
                <div
                    className={hasNext(props.stepNumber, props.stepLinks) ? 'show' : 'hide'}
                >
                    // Insert button here
                </div>
            </div>
        </div>
    );
};
```

A quick look at Design \#1 will tell you that I need to repeat `stepLinks` in every `<MultiStepFormPageTemplate />`. This is very repetitive. However, I can mitigate the repetition by defining `const stepLinks`. Still, it isn't nice. Moreover, I need to configure `stepNumber`, at least for this design draft. This makes the component vulnerable to configuration errors. For example, duplicate `stepNumber` despite the same `stepLinks`. There is a little too much control given to the developer.

One redeeming(?) feature about this design is that each form can exist on its own with its permalink. Another redeeming feature would be minimal modifications to the existing forms. What comes to mind immediately is the extension of the `onSubmit` handlers for each of the forms. These handlers need to route users to the next step link.

Last but not least, query parameters can pass data from one form to another. A Redux persistence middleware is not needed (yet). The step navigation buttons need to preserve these query parameters. They also need to append them to the appropriate step link.

Design \#2:

```typescript
import React, { FC } from 'react';
import { RouteComponentProps } from '@reach/router';

import './style.css'; // .hide { display: none; }

interface Props extends RouteComponentProps {
    components: FC[];
}

const hasPrevious = (stepNumber: number) => {
    return stepNumber > 0;
};

const hasNext = (stepNumber: number, steps: any[]) => {
    return stepNumber < steps.length - 1;
};

export const MultiStepForm: FC<Props> = (props: Props) => {
    // The component defines currentStepNumber, goToPreviousStep and goToNextStep.
    // currentStepNumber refers to the current step number in the multi-step form while
    // goToPreviousStep and goToNextStep are handlers which help the user navigate
    // between adjacent steps.
    return (
        <div className="multi-step-form">
            // Multi-step frontend main component opening tag here
                <div className="progress-bar"></div>
                <div className="form-component">
                    {props.components &&
                        props.components.map((FormComponent: FC) => {
                            return (
                                // Multi-step frontend sub-component opening tag here
                                    <FormComponent />
                                // Multi-step frontend sub-component closing tag here
                            );
                        })}
                </div>
                <div className="step-navigation">
                    <div className={hasPrevious(currentStepNumber) ? 'show' : 'hide'}>
                        <button onClick={goToPreviousStep}>
                            Previous
                        </button>
                    </div>
                    <div className={hasNext(currentStepNumber, props.components) ? 'show' : 'hide'}>
                        <button onClick={goToNextStep}>
                            Next
                        </button>
                    </div>
                </div>
            // Multi-step frontend main component closing tag here
        </div>
    );
};
```

This design is a more conventional way of building multi-step forms. Each step appears/disappears, depending on the user's progress. As such, each step will not have its permalink. Redux can help pass data from one form to another without modifying the child components.

As with the first design, I will need to extend the `onSubmit` handlers for the same reasons.

Both designs seem to apply the template design pattern. I hope I can work on either of them or even a third design. I want to ease the creation and maintenance of multi-step form flows. I should also revise my knowledge of design patterns and principles again. This is so that I can continue to add value and not just LoC.
