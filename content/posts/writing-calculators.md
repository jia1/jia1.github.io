---
title: "Writing Calculators"
date: 2020-09-25T21:23:00+08:00
draft: false
tags: ["software","javascript"]
---
My friends needed an interest calculator. For the simple interest calculator, the parameters are the principal (P), annual interest rate (r), number of months (t) and an optional parameter to represent the periodic (monthly or yearly) top-up amount in addition to the principal (the initial top-up).

Here's v1 of my simple interest calculator:

```javascript
/**
 * Calculates simple interest.
 *
 * Uses the formula A = P(1 + rt).
 *
 * @param {Object} param                     Object containing parameters.
 * @param {Number} param.principal           Principal amount.
 * @param {Number} param.interestRate        Interest rate.
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

Both versions treat `numInterestDeposits` in terms of years and have not handled the periodic top-ups. In addition, the compound interest calculator also has `compoundRate` i.e. number of times the annual interest is compounded in a year. Looks like I still have a long way to go...
