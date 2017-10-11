
library(shiny)
library(readr)
library(car)

source("Logic/variable_analyzr.R")
source("Logic/dataset_manager.R")
source("Server/datasets_index_page.R")
source("Server/dataset_view_page.R")
source("Server/variable_view_page.R")
source("Server/dataset_create_page.R")
source("Server/variable_create_page.R")

# The Shiny server function
shinyServer(function(input, output, session) {
  
  # Object to hold reactive values
  view_reactive_variables = reactiveValues()
  create_reactive_variables = reactiveValues()
  
  # Hide the sidebar by default
  addClass(selector = "body", class = "sidebar-collapse")
  
  # Load server logic for datasets index page
  loadDatasetsIndexPage(input, output, view_reactive_variables)
  
  # Load server logic for dataset view page
  loadDatasetViewPage(input, output, view_reactive_variables)
  
  # Load server logic for variable view page
  loadVariableViewPage(input, output, view_reactive_variables)
  
  # Load server logic for dataset create page
  loadDatasetCreatePage(input, output, session, create_reactive_variables)
  
  # Load server logic for variable create page
  loadVariableCreatePage(input, output, create_reactive_variables)

})
