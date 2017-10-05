
library(shiny)
library(shinydashboard)

source("config_readr.R")

# Develop dashboard header
app_header = dashboardHeader(title = "DataGen V4")

# Disable dashboard sidebar for now
app_sidebar = dashboardSidebar(disable = TRUE)

# Distribution Generation Controls
distribution_definition_box = box(
  title = "Distribution Definition",
  width = 12,
  status = "info",
  selectInput(
    inputId = "distribution_selector", 
    label = "Distribution", 
    choices = unname(getDistributions()), 
    selected = "Gaussian"),
  # Number of points
  sliderInput(
    inputId = "point_count",
    label = "Number of points",
    min = 250,
    max = 10000,
    value = 1000,
    step = 250),
  # 1st Distribution paramter
  uiOutput(
    outputId = "distribution_parameters"
  ),
  # Button to save distribution
  actionButton(
    inputId = "save_distribution",
    label = "Save Distribution")
)

# Distribution Generation Page
generate_distribution_page = fluidPage(
  column(width = 4, distribution_definition_box),
  column(width = 8,
         box(
           title = "Histogram",
           width = 12,
           status = "info",
           plotOutput(outputId = "distribution_hist")),
         box(
           title = "Quantile Summary",
           width = 12,
           status = "info",
           tableOutput(outputId = "distribution_summary")),
         box(
           title = "Scatter Plot",
           width = 12,
           status = "info",
           plotOutput(outputId = "distribution_scatter")),
         box(
           title = "QQ Plot",
           width = 6,
           status = "info",
           plotOutput(outputId = "distribution_qq")),
         box(
           title = "Box Plot",
           width = 6,
           status = "info",
           plotOutput(outputId = "distribution_box")),
         box(
           title = "Data Sample",
           width = 12,
           status = "info",
           uiOutput(outputId = "distribution_samples"))
  )
)

# Develop dashboard body
app_body = dashboardBody(
  generate_distribution_page
)

# Generate Shiny UI
shinyUI(
  dashboardPage(app_header, app_sidebar, app_body)
)


# Notes:
# 1. Separate logic out of shiny 
# 2. Dyanmically construct UI based on a config
# 3. Meta execute functions based on config
# 4. Shiny dashboard: Layout, Boxes
# 5. Output Text Formatting: renderUI + tagList + p + strong

