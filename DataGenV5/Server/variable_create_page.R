
source("Server/variable_view_partial.R")

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

# Append created variable to the current dataset
appendGeneratedDistribution <- function(reactive_variables) {
  generated_distribution_df = data.frame(reactive_variables$generated_distribution)
  names(generated_distribution_df) = reactive_variables$current_variable_name
  if (ncol(reactive_variables$current_dataset) > 0) {
    updated_current_dataset = cbind(reactive_variables$current_dataset,
                                    generated_distribution_df)
  } else {
    updated_current_dataset = generated_distribution_df
  }
  return(updated_current_dataset)
}

# Restore variable create page to initial state
restoreVariableCreatePage <- function(input, output, session, reactive_variables) {
  updateTextInput(session, "variable_name", value = getDefaultVariableName())
  updateSelectInput(session, "distribution_selector", 
                    selected = getInitiallySelectedDistribution())
}


loadVariableCreatePage <- function(input, output, reactive_variables) {
  
  # On back to user report
  observeEvent(input$back_dataset_create, {
    shinyjs::show("dataset_create_page")
    shinyjs::hide("variable_create_page")
  })
  
  # Display variable name
  output$qualified_create_variable_name = renderUI(
    h2(createQualifiedVariableName(
      reactive_variables$current_variable_name,
      reactive_variables$current_dataset_name))
  )
  
  # Generate controls based on selected distribution
  output$distribution_parameters = renderUI({
    selected_distribution = input$distribution_selector
    distribution.params = getDistributionParameters(selected_distribution)
    createParameterControls(distribution.params)
  })
  
  distribution_generator <- observe({
    # Grab values
    selected_distribution = input$distribution_selector
    selected_point_count = reactive_variables$point_count
    # Generate meta distribution
    generated_distribution =
      metaGenerateDistribution(input, selected_distribution, selected_point_count)
    # Save reactive values
    if(!is.null(generated_distribution)) {
      reactive_variables$generated_distribution = generated_distribution
      reactive_variables$distribution_type = selected_distribution
    }
    reactive_variables$current_variable_name = input$variable_name
  })
  
  # Server logic for the variable view partial
  reactive_variables = callModule(
    module = variableViewPartial,
    id = "var_create", 
    reactive_variables)
  
  # Button procedure to Save distribution
  observeEvent(input$add_variable_to_dataset, {
    reactive_variables$current_dataset = 
      appendGeneratedDistribution(reactive_variables)
  })
  
}