

variableViewPartial <- function(input, output, session, reactive_variables) {
  
  # Plot distribution histogram
  output$distribution_hist = renderPlot({
    getHistogram(reactive_variables$generated_distribution)
  })
  
  # Plot distribution 
  output$distribution_scatter = renderPlot({
    getScatterPlot(reactive_variables$generated_distribution)
  })
  
  # QQ plot
  output$distribution_qq = renderPlot({
    getQQPlot(reactive_variables$generated_distribution)
  })
  
  # Box plot
  output$distribution_box = renderPlot({
    getBoxPlot(reactive_variables$generated_distribution)
  })
  
  # Show distribution summary
  output$distribution_summary = renderTable({
    as.data.frame(getSummary(reactive_variables$generated_distribution))
  })
  
  # Show samples
  output$distribution_samples = renderUI({
    # Grab sample list
    sample.list = getSamples(reactive_variables$generated_distribution)
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
  
  # Return 
  return(reactive_variables)
  
}