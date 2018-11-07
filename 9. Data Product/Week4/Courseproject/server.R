# Interactive graphics - brushPoints() function on server.R
library(shiny)
shinyServer(function(input, output) {
  model <- reactive({
    data <- mtcars[, c("mpg", input$predictor), drop = FALSE]
    lm(data[,1] ~ data[,2], data = data)
    
  })
  
  output$slope <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      coef(model())[2]
    }
})
  output$intercept <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      #Otherwise return slope
      coef(model())[1]
    }
  })

  output$plot <- renderPlot({
    
    data <- mtcars[, c("mpg", input$predictor), drop = FALSE]
    plot(data[,2], data[,1], xlab = input$predictor,
         ylab = "MPG", main = "Linear model",
         cex = 1.5, pch = 16, bty = "n")
    if(!is.null(model())){
      abline(model(), col = "blue", lwd = 2)
    }
  
  })
})