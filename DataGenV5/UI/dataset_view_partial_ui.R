

datasetViewPartialUI <- function(id) {
  
  # Namespace function
  ns <- NS(id)
  
  # Define partial components
  tagList(
    box(
      title = "Dataset Details:",
      status = "info",
      width = 12,
      dataTableOutput(ns('dataset_table'))
    )
  )
  
}