First half of this looks awesome. With the qqplots, I suspect these look weird because the sm.qqplot function assumes you're trying to compare your data to a normal distribution. Under the null hypothesis, p-values should follow a uniform distribution. I think in your regression, you're also missing an intercept term, which will affect the p-values you're getting. This being said, qq plots are something you should be able to make yourself, easily enough. Let one of the TAs know if you need help with this (-1). I'm also not entirely sure how the "FDR-corrected" p-values work, it looks like they're getting cut-off at a certain value and I'm not sure why that would be. I would just use the raw pvalues for the qqplots and volcano plot. (-0.5)

5.5/7

- Remade the qqplot
- Fix the p-values for both regressions
- Remade the vovano plot
- 12/10 regrade - 7/7
