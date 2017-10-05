
library(shiny)

# Page title panel
page_title = titlePanel("DataGen V1")

# Side bar with controls
page_sidebar = sidebarPanel(
  # Select distribution
  selectInput(
    inputId = "distribution_selector", 
    label = "Distribution", 
    choices = list("Uniform", "Gaussian", "Poisson"), 
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
  numericInput(
    inputId = "first_distribution_parameter",
    label = "Frist Distribution Parameter",
    value = 0),
  # 2nd Distribution paramter
  numericInput(
    inputId = "second_distribution_parameter",
    label = "Second Distribution Parameter",
    value = 1),
  # Button to save distribution
  actionButton(
    inputId = "save_distribution",
    label = "Save Distribution")
  )

# Main page panel
page_body = mainPanel(
  plotOutput(outputId = "distribution_plot"),
  verbatimTextOutput(outputId = "distribution_summary"),
  tableOutput(outputId = "distribution_table")
  )

# Page Layout
page_layout = sidebarLayout(
  page_sidebar,
  page_body
  )

shinyUI(
  fluidPage(
    page_title,
    br(),
    page_layout
  ))


# Notes:
# Numeric input
# verbatimTextOutput
# tableOutput
# Reactive values


