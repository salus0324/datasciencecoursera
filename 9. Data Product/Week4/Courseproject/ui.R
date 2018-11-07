# Select a predictor to use for univariate linear regression model.

library(shiny)
shinyUI(fluidPage(
  titlePanel("Univeriate linear regression analysis on Mtcars dataset"),
  sidebarLayout(
    sidebarPanel(
      selectInput("predictor", "Choose a predictor to predict mpg",
                  c("Cylinders" = "cyl",
                    "Displacement" = "disp",
                    "Gross horsepower" = "hp",
                    "Weight" = "wt",
                    "Carburetors" = "carb",
                    "Gears" = "gear"))
      
    ),
    mainPanel(
      #
      #Show plot
      plotOutput("plot"),
      h3("Intercept:"),
      #Text output pred1
      textOutput("intercept"),
      h3("Slope:"),
      #Text output pred2
      textOutput("slope")
      
      ))
    )
  )