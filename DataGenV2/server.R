
library(shiny)
library(readr)

shinyServer(function(input, output) {
  
  reactive_values = reactiveValues()

  # Generate and plot distribution
  output$distribution_plot <- renderPlot({
    # Extract parameters
    selected_distribution = input$distribution_selector
    selected_point_count = as.integer(input$point_count)
    selected_first_distribution_parameter = input$first_distribution_parameter
    selected_second_distribution_parameter = input$second_distribution_parameter
    # Genreate distribution
    if (selected_distribution == "Uniform") {
      generated_distribution = runif(n = selected_point_count, 
                                       min = selected_first_distribution_parameter, 
                                       max = selected_second_distribution_parameter)
    } else if (selected_distribution == "Gaussian") {
      generated_distribution = rnorm(n = selected_point_count, 
                                       mean = selected_first_distribution_parameter, 
                                       sd = selected_second_distribution_parameter)
    } else if (selected_distribution == "Poisson") {
      generated_distribution = rpois(n = selected_point_count, 
                                       lambda = selected_first_distribution_parameter)
    }
    # Save reactive values
    reactive_values$generated_distribution = generated_distribution
    reactive_values$distribution_type = selected_distribution
    reactive_values$point_count = selected_point_count
    # draw the histogram with the specified number of bins
    hist(generated_distribution, breaks = 25, col = 'red', border = 'white')
  })
  
  output$distribution_summary <- renderPrint({
    summary(reactive_values$generated_distribution)
  })
  
  output$distribution_table <- renderTable({
    head(reactive_values$generated_distribution)
  })
  
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
