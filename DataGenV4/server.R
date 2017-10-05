
library(shiny)
library(readr)
library(car)

source("variable_analyzr.R")

# Create controls for config defined distribution paramters
createParameterControls <- function(passed.params) {
  controls = lapply(passed.params, function(passed.param) {
    control = numericInput(
    inputId = passed.param$id,
    label = passed.param$label,
    value = passed.param$initial_value)
    return(control)
    })
}

# Meta programming to generate distribution
metaGenerateDistribution <- function(input, selected_distribution, selected_point_count) {
  distribution_function = getDistributionFunction(selected_distribution)
  distribution_paramter_ids = getDistributionParamterIds(selected_distribution)
  paramter_values = sapply(distribution_paramter_ids, function(x) {input[[x]]})
  if (!any(sapply(paramter_values, is.null))) {
    expression = paste(distribution_function, "(",
                       paste(c(selected_point_count, paramter_values), collapse = ","),
                       ")", sep = "")
    generated_distribution = eval(parse(text = expression))
    return(generated_distribution)
  } else {
    return(NULL)
  }
}

# The Shiny server function
shinyServer(function(input, output) {
  
  # Object to hold reactive values
  reactive_values = reactiveValues()
  
  # Generate controls based on selected distribution
  output$distribution_parameters = renderUI({
    selected_distribution = input$distribution_selector
    distribution.params = getDistributionParameters(selected_distribution)
    createParameterControls(distribution.params)
  })
  
  # Observer to generate distribution
  distribution_generator <- observe({
    # Grab values
    selected_distribution = input$distribution_selector
    selected_point_count = as.integer(input$point_count)
    # Generate meta distribution
    generated_distribution =
      metaGenerateDistribution(input, selected_distribution, selected_point_count)
    # Save reactive values
    if(!is.null(generated_distribution)) {
      reactive_values$generated_distribution = generated_distribution
      reactive_values$distribution_type = selected_distribution
      reactive_values$point_count = selected_point_count
    }
  })

  # Plot distribution histogram
  output$distribution_hist = renderPlot({
    getHistogram(reactive_values$generated_distribution)
  })
  
  # Plot distribution 
  output$distribution_scatter = renderPlot({
    getScatterPlot(reactive_values$generated_distribution)
  })
  
  # QQ plot
  output$distribution_qq = renderPlot({
    getQQPlot(reactive_values$generated_distribution)
  })
  
  # Box plot
  output$distribution_box = renderPlot({
    getBoxPlot(reactive_values$generated_distribution)
  })
  
  # Show distribution summary
  output$distribution_summary = renderTable({
    as.data.frame(getSummary(reactive_values$generated_distribution))
  })
  
  # Show samples
  output$distribution_samples = renderUI({
    # Grab sample list
    sample.list = getSamples(reactive_values$generated_distribution)
    # Flatten vectors
    flat.list = lapply(sample.list, function(x) {as.character(paste(x, collapse = ", "))})
    # Interleaf names and flat values in a new list
    flat.list = as.list(unlist(c(names(sample.list), unname(flat.list)))[order(rep(c(1:length(sample.list)), 2))])
    # Render HTML: Bolden titles and apply a paragraph to all
    tagList(lapply(flat.list, function(x) {
      if(grepl(",", x)) {
        tags$p(x)
      } else {
        tags$p(tags$strong(x))
      }
    }))
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
