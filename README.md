# Formula-Formatter
LWC for format formula

This LWC does not work with mixed formulas, for example: condition1 && NOT(condition2)

Example for formula : 

1)  AnnualRevenue < 0 && !(ISBLANK(BillingCity ) || (AnnualRevenue > 10))

2)  NOT(AND(AnnualRevenue < 0 , NOT(ISBLANK(BillingCity ))))
