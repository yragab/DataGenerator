
library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)

source("Config/config_readr.R")
source("UI/variable_create_page_ui.R")
source("UI/datasets_index_page_ui.R")
source("UI/dataset_view_page_ui.R")
source("UI/variable_view_page_ui.R")
source("UI/dataset_create_page_ui.R")

# CREATE INDIVIDUAL PAGES:
# Craete datasets index page
dataset_create_page = datasetCreatePageUI()
# Variable create page
variable_create_page = variableCreatePageUI()
# Create datasets index page
datasets_index_page = datasetsIndexPageUI()
# Create dataset view page
dataset_view_page = datasetViewPageUI()
# Create variable create page
variable_view_page = variableViewPageUI()
# Help page
help_page = fluidPage()
# Source page
source_page = fluidPage()

# CREATE DRILL DOWN STACKS
# Create dataset_browser
dataset_browser = fluidPage(
  useShinyjs(),
  div(id = "datasets_index_page", datasets_index_page),
  hidden(div(id = "dataset_view_page", dataset_view_page)),
  hidden(div(id = "variable_view_page", variable_view_page))
)
# Create dataset_creator
dataset_creator = fluidPage(
  useShinyjs(),
  div(id = "dataset_create_page", dataset_create_page),
  hidden(div(id = "variable_create_page", variable_create_page))
)

# CREATE APP
# Define app header
app_header = dashboardHeader(title = "DataGen V5")
# Define app sidebar
app_sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Create Dataset", tabName = "dataset_create_page", icon = icon("plus-circle")),
    menuItem(text = "Datasets", tabName = "dataset_browser", icon = icon("database"), selected = TRUE),
    menuItem(text = "Help", tabName = "help_page", icon = icon("question-circle")),
    menuItem(text = "Source", tabName = "source_page", icon = icon("code"))
  )
)
# Develop app page structure
app_body = dashboardBody(
  useShinyjs(),
  tabItems(
    tabItem(tabName = "dataset_browser", dataset_browser),
    tabItem(tabName = "dataset_create_page", dataset_creator),
    tabItem(tabName = "help_page", help_page),
    tabItem(tabName = "source_page", source_page)
  )
)

# GENERATE SHINY UI
shinyUI(
  dashboardPage(app_header, app_sidebar, app_body)
)



# Notes:
# 1. Separate ui.R into multiple files
# 2. Separate server.R into multiple files
# 3. Modualrity (partials) in Rshiny 
# 4. DT
# 5. Drill down and ShinyJS
# 6. CSS styles
# 7. updateTextInput

