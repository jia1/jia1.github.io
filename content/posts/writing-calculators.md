---
title: "Writing Calculators"
date: 2020-09-25T21:23:00+08:00
draft: false
tags: ["javascript"]
---
My friends needed an interest calculator. For the simple interest calculator, the parameters are:

- The principal (P),
- Annual interest rate (r),
- Number of months (t), and
- An optional parameter to represent a periodic top-up amount.

Here's v1 of my simple interest calculator:

```javascript
/**
 * Calculates simple interest.
 *
 * Uses the formula A = P(1 + rt).
 *
 * @param {Object} param Object containing parameters.
 * @param {Number} param.principal Principal amount.
 * @param {Number} param.interestRate Interest rate.
 * @param {Number} param.numInterestDeposits Number of time periods.
 *
 * @return {Object} Object containing totalAmount and totalInterest.
 */
export const calcSimpleInterest = ({
 principal,
 interestRate,
 numInterestDeposits,
}) => {
 const totalInterest = principal * interestRate * numInterestDeposits;
 return {
 totalAmount: principal + totalInterest,
 totalInterest,
 };
};
```

And here's v2 of it:

```javascript
import nerdamer from 'nerdamer/nerdamer.core';
import Algebra from 'nerdamer/Algebra';
import Calculus from 'nerdamer/Calculus';
import Solve from 'nerdamer/Solve';

export const calcSimpleInterest = ({
 principal,
 interestRate,
 numInterestDeposits,
}) => {
 const totalAmount = solveForOneUnknownVariable(
 'a=p+p*r*t',
 {
 p: principal.toString(),
 r: interestRate.toString(),
 t: numInterestDeposits.toString(),
 },
 'a',
 principal,
 );
 return {
 totalAmount,
 totalInterest: totalAmount - principal,
 };
};

const solveForOneUnknownVariable = (
 equationString,
 knownValues,
 unknownVariable,
 defaultValue,
) => {
 const equation = nerdamer(equationString).evaluate(knownValues);
 const solution = equation.solveFor(unknownVariable);
 return Number(solution.text());
};
```

Both versions treat `numInterestDeposits` in years and have not handled the periodic top-ups. Also, the compound interest calculator has `compoundRate`. The compound rate is the number of times the annual interest compounds in a year. It looks like I still have a long way to go...
