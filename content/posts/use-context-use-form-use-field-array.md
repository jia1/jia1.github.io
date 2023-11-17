---
title: "useContext, useForm, and useFieldArray"
date: 2023-11-17T16:55:00+08:00
draft: false
tags: ["react","react-hook-form"]
---
I am fortunate to have the opportunity to work with `react-hook-form` again. And work with it better. The following worked well for me:

```typescript
// MultiStepForm.tsx

import { createContext, Dispatch, SetStateAction } from 'react'
import {
  SubmitHandler,
  useFieldArray,
  UseFieldArrayReturn,
  useForm,
  UseFormReturn,
} from 'react-hook-form'

interface SomeComplexInput {
    someKey: string
    someValue: string
}

interface MultiStepFormInput {
    formFieldA: string
    formFieldB: SomeComplexInput[]
}

interface OtherContext {
    // Other frontend-specific values e.g. active form step index
}

export const MultiStepFormContext = createContext(
  {} as UseFormReturn<MultiStepFormInput> &
    UseFieldArrayReturn<MultiStepFormInput, 'formFieldB', 'id'> &
    OtherContext,
)

export const MultiStepForm = () => {
    const form = useForm<MultiStepFormInput>({
        mode: 'all',
    })
    // Use fieldArray.replace and the like to change form fields on the fly
    const fieldArray = useFieldArray<MultiStepFormInput>({
        control: form.control,
        name: 'formFieldB',
    })

    const onSubmit: SubmitHandler<MultiStepFormInput> = (data: MultiStepFormInput) => {
        // Send data to your server
    }

    return (
        <form onSubmit={form.handleSubmit(onSubmit)}>
            <MultiStepFormContext.Provider
                value={{
                    ...form,
                    ...fieldArray,
                    // values from OtherContext
                }}
            >
                <SubsetOfFormFields />
            </MultiStepFormContext.Provider>
        </form>
    )
}
```

```typescript
// SubsetOfFormFields.tsx

import { Input } from '@chakra-ui/react'

import { useContext } from 'react'

import { MultiStepFormContext } from './MultiStepForm'

export const SubsetOfFormFields = () => {
    const { fields, register } = useContext(MultiStepFormContext)

    // Inside map, field has access to both someKey and someValue
    return fields.map((field, index) => (
        <Input
          key={field.id}
          {...register(`formFieldB.${index}.someValue`)}
        />
    ))
}
```

Although `SubsetOfFormFields` is a direct child of `MultiStepForm`, I pass information via context. Any other child component will not have to define extensive prop interfaces. They can call `useContext`.

This decision does not suggest we should always opt for context. I use context when sharing information between stateful components. As for presentational ones, I pass information to them via props. I see `SubsetOfFormFields` as a stateful component. I see presentational components as pure functions that do not mutate any state outside of itself.

For the sharp-eyed, you may have seen `useFormContext` and `FormProvider` in `react-hook-form`'s docs. Well, I forgot about it. If time and mood permit, I'll investigate if I can add values from `OtherContext` into `FormProvider`. With type safety.

References:
- [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
- [useFormContext](https://react-hook-form.com/docs/useformcontext)
- [FormProvider](https://react-hook-form.com/docs/formprovider)
