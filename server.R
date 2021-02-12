library(shiny)
library(quantmod)
source("helpers.R")



# Server logic
shinyServer( function(input, output) {

  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    
      })
  dataInput2 <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })

  output$plot <- renderPlot({
    

    chartSeries(dataInput2(), theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })

})

# Run the app
# shinyApp(ui, server)
