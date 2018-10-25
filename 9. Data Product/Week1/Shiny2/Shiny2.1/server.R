library(shiny)
shinyServer(function(input, output) {
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
  #Two different model
  model1 <- lm(hp ~ mpg, data = mtcars)
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
  
  #Reactive function for model1 prediction. 
  model1pred <- reactive({
    #Get user input sliderMpg
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg = mpgInput))
  })
  #Reactive function for model2 prediction. 
  model2pred <- reactive({
    #Get user input sliderMpg
    mpgInput <- input$sliderMPG
    predict(model2, newdata = 
              data.frame(mpg = mpgInput,
                         mpgsp = ifelse(mpgInput - 20 > 0,
                                        mpgInput - 20, 0)))
  })
  ######OUTPUT######
  # Create output plot1
  output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG
    #1. Display raw data
    plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
         ylab = "Horsepower", bty = "n", pch = 16,
         xlim = c(10, 35), ylim = c(50, 350))
    #2. Display regression line
    #Show model1 and/or model2 based on the user checkbox input
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
      ))
      lines(10:35, model2lines, col = "blue", lwd = 2)
    }
    #Legend. x, y coordinate, name, size etc...
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    #Display predicted value on the plot. Put () after model1/2pred to return number
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  # Create output pred1
  output$pred1 <- renderText({
    #Put () after model1pred to return number
    model1pred()
  })
  # Create output pred2
  output$pred2 <- renderText({
    #Put () after model2pred to return number
    model2pred()
  })
})