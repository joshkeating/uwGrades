# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(RColorBrewer)

data <- read.csv("/home/josh/Code/uwGrades/resources/gradeData.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("UW Professor Comparisons By Class"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        
      
      
      textInput("text", label = h3("Select a Course"), value = "CSE 142"),
      
      # displays some help text for the user
      helpText("Note: Syntax of class input should be abbreviation of ",
               "the class followed by the course number i.e INFO 200."),
      
      selectInput("select", label = h3("Select Year"), 
                  choices = c(unique(as.character(data$Year))),
                  selected = 2014),
      
      helpText("Note: Select year to view grade distribution.")
      
    ),
    
    
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      
      
      plotlyOutput("plot")
      
      # dataTableOutput('table')
      
      
    )
  )
))
