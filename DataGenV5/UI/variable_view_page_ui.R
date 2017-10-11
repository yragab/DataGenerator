
source("UI/variable_view_partial_ui.R")

variableViewPageUI <- function() {
  
  # Create page header
  page_header_box = box(
    actionLink(
      inputId = "back_dataset",
      label = "Back",
      icon = icon("long-arrow-left")),
    htmlOutput(outputId = "qualified_variable_name"),
    status = "info",
    width = 12
  )
  
  # Variable view partial
  variable_view_partial = variableViewPartialUI("var_view")
  
  # Distribution Generation Page
  variable_view_page = fluidPage(
    fluidRow(
      column(width = 12, page_header_box)
    ),
    fluidRow(
      column(width = 12, variable_view_partial)
    )
  )
  
  return(variable_view_page)
  
}
