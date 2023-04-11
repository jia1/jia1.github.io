---
title: "Calculator V2"
date: 2020-10-04T22:32:00+08:00
draft: false
tags: ["javascript"]
---
I made some changes to my compound interest calculator after reading up on ["future value"](https://www.thecalculatorsite.com/articles/finance/future-value-formula.php). My calculator will allow users to specify regular deposits. This is so that they can see for themselves the importance of every dollar added to their savings.

```javascript
import nerdamer from 'nerdamer/nerdamer.core';
import Algebra from 'nerdamer/Algebra';
import Calculus from 'nerdamer/Calculus';
import Solve from 'nerdamer/Solve';

const totalMonthsPerYear = 12;

export const calcCompoundInterest = ({
  principal,
  depositAmountPerMonth = 0,
  interestRatePerAnnum,
  compoundRatePerMonth = 1,
  totalMonths,
}) => {
  const totalAmount = solveForOneUnknownVariable(
    'a=(p*(1+(r/n))^(n*t))+(q*(((1+(r/n))^(n*t)-1)/(r/n)))',
    {
      p: principal.toString(),
      q: depositAmountPerMonth.toString(),
      r: (interestRatePerAnnum / totalMonthsPerYear).toString(),
      n: compoundRatePerMonth.toString(),
      t: totalMonths.toString(),
    },
    'a',
    principal,
  );
  return {
    totalAmount,
    totalInterest:
      totalAmount - (principal + depositAmountPerMonth * totalMonths),
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

Before I can mark [my pull request](https://github.com/calcsg/core/pull/5) as ready for review, I will need to do "Generation of amortisation tables". Having just a table of values alone seems like a turn-off. I went to look for loan amortisation calculators and found that [one of them](https://www.amortization-calc.com/) also generates a line graph. Even then, would this be informative?

A few months ago, I used an Excel sheet to simulate my future mortgage loan that will come in 2+ years. I remember changing the deposit and loan term to see how the monthly payment and total interest vary. Could this be something any other user would want to know as well? This could be why Robo-advisor platforms have range sliders on their homepages. Potential clients get to use these sliders to simulate their potential investment returns.

These sliders are frontend components. But, since my tasks seem to focus on functionality, I should write a function to return tabular data.
