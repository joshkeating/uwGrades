# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)

data <- read.csv("/home/josh/Code/uwGrades/resources/gradeData.csv", stringsAsFactors = FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$value <- renderPrint({ input$text })
  
  output$selct <- renderPrint({ input$select })
  
  
  
  datasetInput <- reactive({
    
    validate(
      need(input$text != "", 'Please enter a class.')
    )
    
    year.trimmed <- filter(data, Class == toupper(input$text), Year == input$select)
    
    # removes dropped class data
    year.trimmed$W <- NULL
    # sets NA values to 0
    year.trimmed[is.na(year.trimmed)] <- 0
    
    
    
    
    # return(year.trimmed)
    
    
    p <- plot_ly(year.trimmed, x = ~Primary_Instructor, y = ~Average_GPA, type = 'bar', name = 'Autum') %>%
      # add_trace(y = ~LA_Zoo, name = 'LA Zoo') %>%
      layout(yaxis = list(title = 'Average GPA'), barmode = 'group')
      return(p)
    
  })
  
  output$plot <- renderPlotly({
    datasetInput()
  })
  
  
  # output$table <- renderDataTable(datasetInput())
  
  
  
})
