library(shiny)
shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      #data name, text, starting value, min, max, and step for each button click
      numericInput("numeric", "How Many Random Numbers Should be Plotted?",
                   value = 1000, min = 1, max = 1000, step = 1),
      #slider name, text, min, max, starting values
      sliderInput("sliderX", "Pick Minimum and Maximum X Values",
                  -100, 100, value = c(-50, 50)),
      #slider name, text, min, max, starting values
      sliderInput("sliderY", "Pick Minimum and Maximum Y Values",
                  -100, 100, value = c(-50, 50)),
      #Name, text and starting value
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
    mainPanel(
      #Text
      h3("Graph of Random Points"),
      #Display plot
      plotOutput("plot1")
    )
  )
))

