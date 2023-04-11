---
title: "Captcha isValid()"
date: 2020-10-18T19:30:00+08:00
draft: false
tags: ["angular"]
---
I needed the client to check for the captcha failure when a user loads a form. In the `captchaService` abstraction for `angular-recaptcha`, there was `isValid()` which does:

```typescript
/**
 * Check if the response has been set, assuming captcha is enabled.
 */
this.isValid = () => this.response || !this.enabled;
```

I had a way to trigger the captcha failure. In the same WiFi network, I accessed a form from `localhost` through my mobile phone. However, both desktop and mobile had the same `isValid()` boolean values. I had the following lines in the form's directive:

```typescript
let i = 0;
$interval(() => {
  Toastr.error(
    `${i++}: ${scope.form.hasCaptcha}, ${scope.form.isPreview}, ${captchaService.isValid()}`,
  )
}, 3000);
```

For both desktop and mobile, the toast shows:

1. `0: true, false, true`.
1. `1: true, false, false`.
1. `2: true, false, false`.
1. `3: true, false, false`.

I also noticed that the captcha widget at the bottom of the form does not show the failure immediately on my mobile phone. As for desktop, the widget never showed any failure despite the toast printing `false` for `isValid()`. I observed the same results with the following if-conditions:

```typescript
if (
  scope.form.hasCaptcha &&
  !scope.form.isPreview &&
  !captchaService.isValid()
) {
  Toastr.error(
    'Error: Cannot connect to reCAPTCHA. Please check your internet connectivity or try submitting on another device.',
  )
}
```

I copied these if-conditions from the `checkCaptchaAndSubmit` function in the form directive. Perhaps I should look into other parts of the captcha service such as `expire()`.
