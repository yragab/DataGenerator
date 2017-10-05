
library(shiny)
library(readr)

shinyServer(function(input, output) {
  
  generated_distribution = NULL
  selected_distribution = NULL
  
  # Generate and plot distribution
  output$distribution_plot <- renderPlot({
    # Extract parameters
    selected_distribution <<- input$distribution_selector
    selected_point_count = as.integer(input$point_count)
    selected_first_distribution_parameter = as.integer(input$first_distribution_parameter)
    selected_second_distribution_parameter = as.integer(input$second_distribution_parameter)
    # Genreate distribution
    if (selected_distribution == "Uniform") {
      generated_distribution <<- runif(n = selected_point_count, 
                                     min = selected_first_distribution_parameter, 
                                     max = selected_second_distribution_parameter)
    } else if (selected_distribution == "Gaussian") {
      generated_distribution <<- rnorm(n = selected_point_count, 
                                     mean = selected_first_distribution_parameter, 
                                     sd = selected_second_distribution_parameter)
    } else if (selected_distribution == "Poisson") {
      generated_distribution <<- rpois(n = selected_point_count, 
                                     lambda = selected_first_distribution_parameter)
    }
    # draw the histogram with the specified number of bins
    hist(generated_distribution, breaks = 25, col = 'red', border = 'white')
  })
  
  observeEvent(input$save_distribution, {
    # Write csv
    if (!is.null(generated_distribution)) {
      write_csv(data.frame(id = 1:length(generated_distribution), value = generated_distribution), 
                paste("generated_distributions/", selected_distribution, 
                      gsub(":| |-", "_", as.character(Sys.time()), 
                           perl = TRUE), ".csv", sep = ""))
    }
  })

})
