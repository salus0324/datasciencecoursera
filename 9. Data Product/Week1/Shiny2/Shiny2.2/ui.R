# Delayed reactivity. You can use submit button in your app.
library(shiny)
shinyUI(fluidPage(
  #Title
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(
    #sidebarPanel collects input
    sidebarPanel(
      #sliderinput name, text, min, max, default value
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
      #Checkbox input name, text, default value
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      #Submit Button!
      submitButton("Submit")
      ),
    #mainPanel displays output
    mainPanel(
      #Show plot
      plotOutput("plot1"),
      h3("Predicted Horsepower from Model 1:"),
      #Text output pred1
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2:"),
      #Text output pred2
      textOutput("pred2")
    )
  )
))