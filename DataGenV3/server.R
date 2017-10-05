
library(shiny)
library(readr)

shinyServer(function(input, output) {
  
  # Object to hold reactive values
  reactive_values = reactiveValues()
  
  # Generate controls based on distribution selection
  output$distribution_parameters = renderUI({
    selected_distribution = input$distribution_selector
    if (selected_distribution == "Uniform") {
      tagList(
        numericInput(
          inputId = "first_distribution_parameter",
          label = "Min",
          value = 0),
        numericInput(
          inputId = "second_distribution_parameter",
          label = "Max",
          value = 1))
    } else if (selected_distribution == "Gaussian") {
      tagList(
        numericInput(
          inputId = "first_distribution_parameter",
          label = "Mean",
          value = 0),
        numericInput(
          inputId = "second_distribution_parameter",
          label = "Standard Deviation",
          value = 1))
    } else if (selected_distribution == "Poisson") {
      tagList(
        numericInput(
          inputId = "first_distribution_parameter",
          label = "Lambda",
          value = 3))
    }
  })
  
  # Observer to generate distribution
  distribution_generator <- observe({
    if (!is.null(input$first_distribution_parameter)) {
      # Extract parameters
      selected_distribution = input$distribution_selector
      selected_point_count = as.integer(input$point_count)
      # Genreate distribution
      if (selected_distribution == "Uniform") {
        selected_first_distribution_parameter = input$first_distribution_parameter
        selected_second_distribution_parameter = input$second_distribution_parameter
        generated_distribution = runif(n = selected_point_count,
                                       min = selected_first_distribution_parameter,
                                       max = selected_second_distribution_parameter)
      } else if (selected_distribution == "Gaussian") {
        selected_first_distribution_parameter = input$first_distribution_parameter
        selected_second_distribution_parameter = input$second_distribution_parameter
        generated_distribution = rnorm(n = selected_point_count,
                                       mean = selected_first_distribution_parameter,
                                       sd = selected_second_distribution_parameter)
      } else if (selected_distribution == "Poisson") {
        selected_first_distribution_parameter = input$first_distribution_parameter
        generated_distribution = rpois(n = selected_point_count,
                                       lambda = selected_first_distribution_parameter)
      }
      # Save reactive values
      reactive_values$generated_distribution = generated_distribution
      reactive_values$distribution_type = selected_distribution
      reactive_values$point_count = selected_point_count
    }
  })

  # Plot distribution
  output$distribution_plot = renderPlot({
    hist(reactive_values$generated_distribution, breaks = 25, col = 'red', border = 'white')
  })
  
  # Show distribution summary
  output$distribution_summary = renderPrint({
    summary(reactive_values$generated_distribution)
  })
  
  # Show actual distribution
  output$distribution_table = renderTable({
    head(reactive_values$generated_distribution)
  })
  
  # Button procedure to Save distribution
  observeEvent(input$save_distribution, {
    generated_distribution = reactive_values$generated_distribution
    distribution_type = reactive_values$distribution_type
    point_count = reactive_values$point_count
    # Write csv
    if (!is.null(generated_distribution)) {
      write_csv(data.frame(id = 1:length(generated_distribution), value = generated_distribution), 
                paste("generated_distributions/", distribution_type, "_", point_count, "_",
                      gsub(":| |-", "_", as.character(Sys.time()), 
                           perl = TRUE), ".csv", sep = ""))
    }
  })
  
})
