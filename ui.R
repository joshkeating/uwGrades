# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)

data <- read.csv("./resources/gradeData.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("UW Professor Comparisons By Class"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        
      textInput("text", label = h3("Select a Course"), value = "cse 142"),
      
      # displays some help text for the user
      helpText("Syntax of class input should be abbreviation of ",
               "the class followed by the course number i.e INFO 200."),
      
      selectInput("select", label = h3("Select Year"), 
                  choices = c(unique(as.character(data$Year))),
                  selected = 2014),
      
      helpText("Select year to view grade distribution.")
      
    ),
   
    
    # Show a plot of the generated distribution
    mainPanel(
      
      plotlyOutput("plot")
      
      # dataTableOutput('table')
      
    )
  )
  # ,
  # h3("Notes"),
  # p("If a professor has taught multiple sections of a class either over the year or in a quarter, the averages for that class 
  #   have been averaged into one average GPA for that professor for each year.")
  
))
