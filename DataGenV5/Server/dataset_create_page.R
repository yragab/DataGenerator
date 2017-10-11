
source("Server/dataset_view_partial.R")

restoreDatasetCreatePage <- function(input, output, session, reactive_variables) {
  updateTextInput(session, "dataset_name", value = getDefaultDatasetName())
  updateSliderInput(session, "point_count", value = getDefaultPointCount())
  reactive_variables$current_dataset = data.frame()
}

loadDatasetCreatePage <- function(input, output, session, reactive_variables) {

  # Display dataset name
  output$created_dataset_name = renderUI(
    h2(reactive_variables$current_dataset_name)
  )
  
  # Reactive function to update dataset parameters
  dataset_generator <- observe({
    if(is.null(reactive_variables$current_dataset)) {
      reactive_variables$current_dataset = data.frame()
    }
    reactive_variables$point_count = as.integer(input$point_count)
    reactive_variables$current_dataset_name = input$dataset_name
  })
  
  # Dataset view partial
  reactive_variables = callModule(
    module = datasetViewPartial,
    id = "dataset_create", 
    reactive_variables)
  
  # Add variable to dataset
  observeEvent(input$add_variable, {
    restoreVariableCreatePage(input, output, session, reactive_variables)
    shinyjs::show("variable_create_page")
    shinyjs::hide("dataset_create_page")
  })
  
  # Save dataset to disk
  observeEvent(input$save_dataset, {
    dataset_path = paste(getDataPath(), 
                         reactive_variables$current_dataset_name, 
                         ".csv", sep = "")
    write_csv(reactive_variables$current_dataset, dataset_path)
  })
  
  # Clear dataset
  observeEvent(input$clear_dataset, {
    restoreDatasetCreatePage(input, output, session, reactive_variables)
  })
  
}
