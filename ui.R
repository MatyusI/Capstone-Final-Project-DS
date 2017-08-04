

library(shiny) 
 

shinyUI(fluidPage( 
  titlePanel("--------------------------------  Data Science Final Capstone Project ---------------------------"), 
  h4("Predict the Next Word(s)"), 
  h4("Author: Iren Matyus"), 
  h4("Date: 05.August.2017"), 
  br(), 
  br(), 
  br(), 
  sidebarLayout( 
    sidebarPanel( 
      sliderInput("num.predictions", label = h5("The Number of Word Predictions"), 
                                   min = 1, max = 10, step = 1, value = 1), 
      textInput("words", label = h3("Text input"), 
                                  value = ""), 
      textOutput("echo"), 
      br(), 
      textOutput("text")), 
    mainPanel( 
      span("About the application", style = "color:red"), 
      br(), 
      br(), 
      p("The is a shiny application for the : "), 
      span("Data Science Capstone Project  ", style = "color:blue", 
      " used for predicting n-gram words."), 
      br(), 
      br(), 
      span( "The data set is based on the Swiftkey dataset located at the following URL:", style = "clor:red)",
      a(href = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip")), 
      br(), 
      br(), 
      p("The slider input is used to set ", 
      span("how many Number of Word Predictions", style = "color:green"), 
      "are used to output."), 
      br(), 
      p("You have to input a phrase to Text Input to see the predictions of the next word/words (Predicted word(s) (in probability (descending order)).")
    )     
  ) 
)) 



