# Interactive graphics - brushPoints() function on server.R
library(shiny)
shinyServer(function(input, output) {
  model <- reactive({
    #from user brushing
    #brushed points will be from dataset trees, with xvar Grith and yvar Volume
    brushed_data <- brushedPoints(trees, input$brush1,
                                  xvar = "Girth", yvar = "Volume")
    if(nrow(brushed_data) < 2){
      return(NULL)
    }
    lm(Volume ~ Girth, data = brushed_data)
  })
  
  output$slopeOut <- renderText({
    #If brushed points are less than 2 points
    if(is.null(model())){
      "No Model Found"
    } else {
      #Otherwise return slope
      model()[[1]][2]
    }
  })
  
  output$intOut <- renderText({
    #If brushed points are less than 2 points
    if(is.null(model())){
      "No Model Found"
    } else {
      #Otherwise return intercept
      model()[[1]][1]
    }
  })
  
  output$plot1 <- renderPlot({
    #Create output plot using the raw tree data
    plot(trees$Girth, trees$Volume, xlab = "Girth",
         ylab = "Volume", main = "Tree Measurements",
         cex = 1.5, pch = 16, bty = "n")
    #If there's model created, put a regresion line plot
    if(!is.null(model())){
      abline(model(), col = "blue", lwd = 2)
    }
  })
  
  
})