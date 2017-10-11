

datasetsIndexPageUI <- function() {
  
  datasets_index_page = fluidPage(
    fluidRow(
      box(
        h2("Datasets"),
        status = "info",
        width = 12
      ),
      tabBox(
        id = "dataset-tabset",
        width = 12,
        tabPanel("Builtin Datasets", dataTableOutput('builtin_datasets_table')),
        tabPanel("Created Datasets", dataTableOutput('created_datasets_table'))
      )
    )
  )
  
  return(datasets_index_page)
}