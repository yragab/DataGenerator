

loadDatasetsIndexPage <- function(input, output, reactive_variables) {
  
  # Render Data table for builtin datasets
  output$builtin_datasets_table = renderDataTable({
    datatable(getBuiltinDatasetDetails(),
              rownames = TRUE,
              selection = 'none') %>%
      formatStyle(
        "dataset",
        cursor = 'pointer',
        color = "blue"
      )}
  )
  
  # Render Data table for created datasets establishing reactive dependence on saving a new dataset
  output$created_datasets_table = renderDataTable({
    input$save_dataset
    datatable(getCreatedDatasets(),
              rownames = TRUE,
              selection = 'none') %>%
      formatStyle(
        "dataset",
        cursor = 'pointer',
        color = "blue"
      )}
  )
  
  # Drill down when a built in dataset is clicked
  observeEvent(input$builtin_datasets_table_cell_clicked, {
    cell.details = input$builtin_datasets_table_cell_clicked
    clicked.value = cell.details$value
    if (!is.null(clicked.value)) {
      shinyjs::show("dataset_view_page")
      shinyjs::hide("datasets_index_page")
      reactive_variables$current_dataset_name = clicked.value
      reactive_variables$current_dataset = getDataset(clicked.value)
      reactive_variables$load_dataset_by = "name"
    }
  })
  
  # Drill down when a custom dataset is clicked
  observeEvent(input$created_datasets_table_cell_clicked, {
    cell.details = input$created_datasets_table_cell_clicked
    clicked.value = cell.details$value
    print(clicked.value)
    if (!is.null(clicked.value)) {
      shinyjs::show("dataset_view_page")
      shinyjs::hide("datasets_index_page")
      reactive_variables$current_dataset_name = clicked.value
      reactive_variables$current_dataset = getDataset(clicked.value, by = "path")
      reactive_variables$load_dataset_by = "path"
      
    }
  })

}

