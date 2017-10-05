
library(shiny)

shinyUI(
  fluidPage(

  # Application title
  titlePanel("DataGen V1"), br(),

  # Define a sidebar layout
  sidebarLayout(
    
    # Side bar with controls
    sidebarPanel(
      
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
      textInput(
        inputId = "first_distribution_parameter",
        label = "Frist Distribution Parameter",
        value = 0
      ),
      
      # 2nd Distribution paramter
      textInput(
        inputId = "second_distribution_parameter",
        label = "Second Distribution Parameter",
        value = 1
      ),
      
      # Button to save distribution
      actionButton(
        inputId = "save_distribution",
        label = "Save Distribution"
      )
    ),

    # Main panel with visualization
    mainPanel(
      plotOutput(outputId = "distribution_plot")
    )
  )
))

# Notes:
# 1. Mind the commas and brackets


