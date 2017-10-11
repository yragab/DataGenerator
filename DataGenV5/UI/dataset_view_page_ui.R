
source("UI/dataset_view_partial_ui.R")

datasetViewPageUI <- function() {
  
  # Dataset header box
  dataset_view_header_box = box(
    actionLink(
      inputId = "back_datasets",
      label = "Back",
      icon = icon("long-arrow-left")),
    htmlOutput(outputId = "dataset_name"),
    status = "info",
    width = 12
  )
  
  # Dataset view partial
  dataset_view_partial = datasetViewPartialUI("dataset_view")
  
  # Dataset view page
  dataset_view_page = fluidPage(
    column(
      width = 12, 
      dataset_view_header_box,
      dataset_view_partial
    )
  )
  
  return(dataset_view_page)
}