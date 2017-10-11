
source("Server/variable_view_partial.R")

createQualifiedVariableName <- function(passed.variable.name, passed.dataset.name) {
  qualified_variable_name = paste(passed.dataset.name , "/", passed.variable.name)
  return(qualified_variable_name)
}

loadVariableViewPage <- function(input, output, reactive_variables) {
  
  # On back to user report
  observeEvent(input$back_dataset, {
    shinyjs::show("dataset_view_page")
    shinyjs::hide("variable_view_page")
  })
  
  # Display variable name
  output$qualified_variable_name = renderUI(
    h2(createQualifiedVariableName(
      reactive_variables$current_variable_name,
      reactive_variables$current_dataset_name))
  )
  
  # Server logic for the variable view partial
  reactive_variables = callModule(
    module = variableViewPartial,
    id = "var_view", 
    reactive_variables)

}