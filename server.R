# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)

# initialize dataset
data <- read.csv("./resources/gradeData.csv", stringsAsFactors = FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # define text input widget
  output$value <- renderPrint({ input$text })
  
  # define selection input widget
  output$selct <- renderPrint({ input$select })
  
  # function that filters the dataset and builds a plotly graph
  datasetInput <- reactive({
    
    # filters dataset based on user input based on class and year
    year.trimmed <- filter(data, Class == toupper(input$text), Year == input$select)

    # checks to see if there is (valid) input in the text input widget
    validate(
      need(NROW(year.trimmed) > 0, 'Please enter a valid course name and number.')
    )
    
    # removes dropped class data
    year.trimmed$W <- NULL
    # sets NA values to 0
    year.trimmed[is.na(year.trimmed)] <- 0
    
    # averages the Average_GPA of each teacher over each year
    year.trimmed <- aggregate(year.trimmed$Average_GPA, list(year.trimmed$Primary_Instructor), mean)
    
    # sorts the data to be in decending order
    year.trimmed$Group.1 <- factor(year.trimmed$Group.1, levels = unique(year.trimmed$Group.1)[order(year.trimmed$x, decreasing = TRUE)])
    
    # Uncomment this for data table troubleshooting
    # return(year.trimmed)
    
    # ues this to set label for x axis
    x <- list(title = "Professor")
    
    # puts together the plotly plot
    p <- plot_ly(year.trimmed, x = ~Group.1, y = ~x, type = 'bar', name = 'Average GPA', color = ~Group.1) %>%
      layout(yaxis = list(title = 'Average GPA'), margin = list(b = 180), xaxis = x)
      
    return(p)

  })
  
  # sends datasetInput function output to the plot
  output$plot <- renderPlotly({
    datasetInput()
  })
  
  # Uncomment this for data table troubleshooting
  # output$table <- renderDataTable(datasetInput())
  
})
