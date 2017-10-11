

loadDatasetsIndexPage <- function(input, output, reactive_variables) {
  
  # Render Data table
  output$builtin_datasets_table = renderDataTable(
    datatable(getBuiltinDatasetDetails(),
              rownames = TRUE,
              selection = 'none') %>%
      formatStyle(
        "dataset",
        cursor = 'pointer',
        color = "blue"
      )
  )
  
  # Render Data table
  output$created_datasets_table = renderDataTable(
    datatable(getCreatedDatasets(),
              rownames = TRUE,
              selection = 'none') %>%
      formatStyle(
        "dataset",
        cursor = 'pointer',
        color = "blue"
      )
  )
  

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

