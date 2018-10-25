# Interactive graphics - brush argument in plotOutput on ui.R

library(shiny)
shinyUI(fluidPage(
  titlePanel("Visualize Many Models"),
  sidebarLayout(
    sidebarPanel(
      #Text outputs
      h3("Slope"),
      textOutput("slopeOut"),
      h3("Intercept"),
      textOutput("intOut")
    ),
    mainPanel(
      #
      plotOutput("plot1", brush = brushOpts(
        id = "brush1"
      ))
    )
  )
))