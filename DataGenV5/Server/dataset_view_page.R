
source("Server/dataset_view_partial.R")

loadDatasetViewPage <- function(input, output, reactive_variables) {
  
  # On back to user report
  observeEvent(input$back_datasets, {
    shinyjs::show("datasets_index_page")
    shinyjs::hide("dataset_view_page")
  })
  
  # Display dataset name
  output$dataset_name = renderUI(
    h2(reactive_variables$current_dataset_name)
  )
  
  # Dataset view partial
  reactive_variables = callModule(
    module = datasetViewPartial,
    id = "dataset_view", 
    reactive_variables)
  
  # Handle Drill down
  observe({
    if(!is.null(reactive_variables$generated_distribution)) {
      shinyjs::show("variable_view_page")
      shinyjs::hide("dataset_view_page")
    }
  })

}