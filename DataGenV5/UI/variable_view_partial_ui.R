

variableViewPartialUI <- function(id) {

  # Namespace function
  ns <- NS(id)
  
  # Define partial components
  tagList(
    box(
      title = "Histogram",
      width = 12,
      status = "info",
      plotOutput(outputId = ns("distribution_hist"))),
    box(
      title = "Quantile Summary",
      width = 12,
      status = "info",
      tableOutput(outputId = ns("distribution_summary"))),
    box(
      title = "Scatter Plot",
      width = 12,
      status = "info",
      plotOutput(outputId = ns("distribution_scatter"))),
    box(
      title = "QQ Plot",
      width = 6,
      status = "info",
      plotOutput(outputId = ns("distribution_qq")))
    ,
    box(
      title = "Box Plot",
      width = 6,
      status = "info",
      plotOutput(outputId = ns("distribution_box"))),
    box(
      title = "Data Sample",
      width = 12,
      status = "info",
      uiOutput(outputId = ns("distribution_samples")))
  )
  
}