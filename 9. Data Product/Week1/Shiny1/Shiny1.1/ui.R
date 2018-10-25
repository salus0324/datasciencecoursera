library(shiny)
shinyUI(fluidPage(
  #Simple App
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      h3("Sidebar")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Hey")
    )
  )
))