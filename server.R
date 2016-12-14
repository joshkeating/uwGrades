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
    
    # year.trimmed <- arrange(year.trimmed, desc(Average_GPA))
    
    year.trimmed <- aggregate(year.trimmed$Average_GPA, list(year.trimmed$Primary_Instructor), mean)
    
    # return(year.trimmed)
    
    
    # ax <- list(
    #   type = "Primary_Instructor",
    #   categoryorder = "Primary_Instructor ascending",
    #   showgrid = TRUE,
    #   showline = TRUE,
    #   autorange = TRUE,
    #   showticklabels = TRUE,
    #   ticks = "outside",
    #   tickangle = 0
    # )
    
    
    
    # p <- plot_ly(year.trimmed, x = ~Primary_Instructor, y = ~Average_GPA, type = 'bar', name = 'Average GPA') %>%
    #   add_trace(y = ~c(Autumn, Winter), name = 'Autumn') %>%
    #   
    #   layout(yaxis = list(title = 'Average GPA'), barmode = 'group')
    # return(p)
    # 
    
    p <- plot_ly(year.trimmed, x = ~x, y = ~Group.1, type = 'bar', name = 'Average GPA') %>%
      # add_trace(y = ~A, name = 'A') %>%
      # # add_trace(y = ~'A-', name = 'A-') %>%
      # add_trace(y = ~B, name = 'B') %>%
      # # add_trace(y = ~'B-', name = 'B-') %>%
      layout(yaxis = list(title = 'Average GPA'), barmode = 'stack')
      return(p)
    
  })
  
  output$plot <- renderPlotly({
    datasetInput()
  })
  
  
  # output$table <- renderDataTable(datasetInput())
  
  
  
})
