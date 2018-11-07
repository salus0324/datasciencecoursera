#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(miniUI)

myFirstGadget <- function() {
  ui <- miniPage(
    gadgetTitleBar("My First Gadget")
  )
  server <- function(input, output, session){
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui, server)
}
