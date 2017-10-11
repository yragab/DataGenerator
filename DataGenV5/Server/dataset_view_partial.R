
getCurrentDataset <- function(reactive_variables) {
  if(!is.null(reactive_variables$current_dataset)) {
    current_dataset = reactive_variables$current_dataset
  } else {
    current_dataset = data.frame()
  }
  return(current_dataset)
}

datasetViewPartial <- function(input, output, session, reactive_variables) {
  
  # Render Data table
  output$dataset_table = renderDataTable(
    datatable(getCurrentDataset(reactive_variables), 
              rownames = TRUE,
              selection = 'none')
  )
  
  # Respond to table click event
  observeEvent(input$dataset_table_cell_clicked, {
    cell.details = input$dataset_table_cell_clicked
    clicked.value = cell.details$col
    print(cell.details)
    if (!is.null(clicked.value)) {
      current_variable_name = 
        getVariableName(reactive_variables$current_dataset_name, clicked.value, 
                        reactive_variables$load_dataset_by)
      current_variable = 
        getVariable(reactive_variables$current_dataset_name, clicked.value, 
                    reactive_variables$load_dataset_by)
      if (is.numeric(current_variable)) {
        reactive_variables$current_variable_name = current_variable_name
        reactive_variables$generated_distribution = current_variable
      }
    }
  })
  
  # Return 
  return(reactive_variables)
  
}