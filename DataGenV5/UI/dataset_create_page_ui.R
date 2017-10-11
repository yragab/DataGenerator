
source("UI/dataset_view_partial_ui.R")

datasetCreatePageUI <- function() {
  
  dataset_create_box = box(
    status = "info",
    width = 12,
    h3("Create Dataset"), br(),
    textInput(
      inputId = "dataset_name",
      label = "Dataset Name",
      value = getDefaultDatasetName()),
    # Number of points
    sliderInput(
      inputId = "point_count",
      label = "Number of points",
      min = 250,
      max = 10000,
      value = getDefaultPointCount(),
      step = 250),
    actionButton(
      inputId = "add_variable",
      label = "Add Variable",
      style = "font-weight:bold; color:#fff; background-color:#00C1EF; border-color:#00C1EF; margin:2px",
      icon = icon("plus-circle"),
      width = "95%"),
    br(),
    actionButton(
      inputId = "save_dataset",
      label = "Save Dataset",
      style = "background-color:#dedede; border-color:#dedede; margin:2px",
      icon = icon("download"),
      width = "95%"),
    actionButton(
      inputId = "clear_dataset",
      label = "Start Over",
      style = "background-color:#dedede; border-color:#dedede; margin:2px",
      icon = icon("download"),
      width = "95%")
  )
  
  # Dataset header box
  dataset_create_header_box = box(
    htmlOutput(outputId = "created_dataset_name"),
    status = "info",
    width = 12
  )
  
  # Dataset view partial
  dataset_view_partial = datasetViewPartialUI("dataset_create")
  
  # Consturct the page
  dataset_create_page = fluidPage(
    fluidRow(
      column(width = 4, dataset_create_box),
      column(width = 8, 
             dataset_create_header_box,
             dataset_view_partial)
    )
  )
  
  return(dataset_create_page)
}

