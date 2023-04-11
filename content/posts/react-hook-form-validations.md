---
title: "react-hook-form validations"
date: 2023-04-12T00:12:00+08:00
draft: false
tags: ["react"]
---
Feeling a little abashed about [leaving a bug unresolved for the day](https://github.com/opengovsg/FormSG/pull/6087), but I want take a break while keeping the team posted. And I also want to share what I have learnt. However, if you know what's the problem with my commit, please do not hesitate to reach out!

Back to the main learning point I am trying to share: In [the pull request above](https://github.com/opengovsg/FormSG/pull/6087), look at the first screenshot. The first screenshot was supposed to depict a form field that has gone through the validation function despite being untouched. Based on my understanding of the mockups I was given, this was the intended behaviour.

Though, this was not a default behaviour in `react-hook-form`. So I had to do the following:

```javascript
import { SubmitHandler, useForm } from 'react-hook-form'
...
  const {
    reset,
    trigger,
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<TransferOwnershipInputs>({
    mode: 'onChange',
  })
  ...
  useEffect(() => {
    trigger()
  }, [])
...
```

I have not looked into whether the current approach is the ideal approach. Make it work, make it right, make it fast.

As for the actual validation functions, I got to know of a shorthand through [Stack Overflow](https://stackoverflow.com/questions/66927236/how-do-i-pass-in-a-custom-validate-message-in-react-hook-form). As a result, registration looked like:

```javascript
{...register('email', {
  required: REQUIRED_ERROR,
  validate: (value) => isEmail(value) || INVALID_EMAIL_ERROR,
})}
```

I suppose I could merge the check for `required` into `validate`, but it would not be as readable.
