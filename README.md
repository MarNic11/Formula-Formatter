# Formula-Formatter
LWC for format formula

This LWC does not work with mixed formulas, except for NOT value.

Example for formula : 

1 Case)      AnnualRevenue < 0 && !(ISBLANK(BillingCity ) || (AnnualRevenue > 10))

2 Case)      NOT(AND(AnnualRevenue < 0 , NOT(ISBLANK(BillingCity ))))

IMPORTANT : Do not leave spaces between NOTs and parentheses in the first case and not leave spaces between operators and parentheses in the second case
