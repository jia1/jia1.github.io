---
title: "Calculator V2"
date: 2020-10-04T22:32:00+08:00
draft: false
tags: ["software","javascript"]
---
I made some changes to my compound interest calculator after reading up on ["future value"](https://www.thecalculatorsite.com/articles/finance/future-value-formula.php). My calculator will allow users to specify regular deposits so that they can see for themselves the importance of every dollar added to their monthly or yearly savings and/or financial instruments.

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

Before I can mark [my pull request](https://github.com/calcsg/core/pull/5) as ready for review, I will need to do "Generation of amortization tables". Having just a table of values alone seems like a turn-off. I went to look for loan amortisation calculators and found that [one of them](https://www.amortization-calc.com/) also generates a line graph. Even then, would this be informative?

A few months ago, I used an Excel sheet to simulate my future mortgage loan which will come in 2+ years. I remember changing the deposit and loan term to see how the monthly payment and total interest vary. Could this be something any other user would want to know as well? This could be why the robo-advisors (e.g. [Endowus](https://endowus.com/) and [StashAway](https://www.stashaway.sg/)) have range sliders on their homepage, for potential clients to simulate their potential investment returns.

These sliders are frontend components. Since my tasks seem to be about functionality (there's barely any code right now), I should write a function to return tabular data.
