
#' Plot coefficients of a linear model
coef_plot = function(mod, alpha = 0.05, remove_intercept = TRUE){
  lm_summary = summary(mod)$coefficients
  rownames(lm_summary) = pretty_rownames(rownames(lm_summary))

  df = data.frame(Features = rownames(lm_summary),
    Estimate = lm_summary[,'Estimate'],
    std_error = lm_summary[,'Std. Error'])
  df$lower = df$Estimate - qnorm(alpha/2) * df$std_error
  df$upper = df$Estimate + qnorm(alpha/2) * df$std_error


  if(remove_intercept){
    df = df[!(df$Features == '(Intercept)'),]
  }
  require("ggplot2")
  ggplot(df) +
    geom_vline(xintercept=0, linetype=4) +
    geom_point(aes(x=Estimate, y=Features)) +
    geom_segment(aes(y=Features, yend=Features, x=lower, xend=upper), arrow = arrow(angle=90, ends='both', length = unit(0.1, 'cm'))) +
    scale_x_continuous('Weight estimate') +
    my_theme()
}
