
source("UI/variable_view_partial_ui.R")

variableCreatePageUI <- function() {
  
  # Create page header
  page_header_box = box(
    actionLink(
      inputId = "back_dataset_create",
      label = "Back",
      icon = icon("long-arrow-left")),
    htmlOutput(outputId = "qualified_create_variable_name"),
    status = "info",
    width = 12
  )
  
  # Distribution Generation Controls
  variable_definition_box = box(
    title = "Distribution Definition",
    width = 12,
    status = "info",
    textInput(
      inputId = "variable_name",
      label = "Variable Name",
      value = getDefaultVariableName()),
    selectInput(
      inputId = "distribution_selector", 
      label = "Distribution", 
      choices = unname(getDistributions()), 
      selected = getInitiallySelectedDistribution()),
    uiOutput(
      outputId = "distribution_parameters"
    ),
    # Button to add distribution to dataset
    actionButton(
      inputId = "add_variable_to_dataset",
      label = "Save Variable")
  )
  
  # Variable view partial
  variable_preview_partial = variableViewPartialUI("var_create")
  
  # Distribution Generation Page
  variable_create_page = fluidPage(
    column(width = 4, variable_definition_box),
    column(width = 8, 
           page_header_box,
           variable_preview_partial)
  )
  
  return(variable_create_page)
  
}
