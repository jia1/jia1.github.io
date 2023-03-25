---
title: "react-hook-form"
date: 2023-03-25T12:35:00+08:00
draft: false
tags: ["software","library","javascript","react"]
---
It's been a while since I last had the chance to assess several libraries to solve parts of a problem. My most recent project required me to evaluate JavaScript libraries which make form management a breeze. The "me" in the past would have jumped at any first possibility, like how a chick imprints on the first living thing they see. Not anymore.

My ex-company taught me to set up decision tables and make recommendations according to concrete criteria and their priorities. I thought hard about the non-negotiables and nice-to-haves. For instance, since the company has a design system, the chosen library should be compatible with such an arrangement. And so on.

After much deliberation, I decided against jQuery libraries as I cannot measure the cost of [getting jQuery to coexist with React](https://legacy.reactjs.org/docs/integrating-with-other-libraries.html). The company supports the React ecosystem heavily - it would be painful to risk losing that support. The other React libraries had performance and reliability shortcomings. I eventually had my eyes set on this library called [`react-hook-form`](https://github.com/react-hook-form/react-hook-form). Proper justification ensued.

To be frank, that was actually the first thing I saw, especially since [FormSG](https://github.com/opengovsg/FormSG) was already tapping onto it. Furthermore, it was only pretty recent that they rewrote their codebase from Angular into React. It's like someone else already did the research for me. But, of course, I just can't tell my team that someone outside of the company decided to go with this and hence us too.

Less than a month into this, I'm glad to say I made the right choice. The library saved me from having to worry about form state and validation. I could nest my form components without worries. The documentation was clear and concise, too.

It was unfortunate I didn't have enough time to unravel some unexpected behaviour when getting the internal design system to work with this library. I think this is really something to do with the design system. On some form components, [`register`](https://react-hook-form.com/api/useform/register/) did not work. Values did not get set. Digging deep into the design system is out-of-scope. As such, I proceeded to call [`setValue`](https://react-hook-form.com/api/useform/setvalue/) with `{ shouldValidate: true }` on the relevant events.

If you get stuck in a similar situation, try the above workaround. As the saying goes, "Make it work. Make it better. Make it faster."
