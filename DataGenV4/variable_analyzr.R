
library(car)

getSummary <- function(passed.variable) {
  summary = as.list(summary(passed.variable))
  return(summary)
}

getQQPlot <- function(passed.variable) {
  qqplot(rnorm(1000), passed.variable, 
         col = 'red', border = 'white')
}

getScatterPlot <- function(passed.variable) {
  plot(passed.variable, 
       col = 'red', border = 'white')
}

getHistogram <- function(passed.variable) {
  hist(passed.variable, 
       breaks = 25, col = 'red', border = 'white')
}

getBoxPlot <- function(passed.variable) {
  boxplot(passed.variable, border = "red")
}

getSamples <- function(passed.variable) {
  samples = list(
    "head" = head(passed.variable, 5),
    "some" = some(passed.variable, 5),
    "tail" = tail(passed.variable, 5))
  return(samples)
}