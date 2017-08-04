


library(shiny) 
library(sp) 

source("predictWords.R") 


shinyServer( 
  function(input, output){ 
    getWords <- reactive({ 
    trimws(input$words) 
    }) 
    output$echo <- renderText({ 
      if (nchar(getWords()) > 0) { 
        paste0("You have entered the text: ", getWords()) 
      } else { 
        "No text entered (whitespaces eliminated)" 
      } 
    }) 
    result <- reactive({ 
      predictWord(getWords(), input$num.predictions) 
    }) 
    output$text <- renderText({ 
      paste("Predicted word(s) (descending order in probability )):", result()) 
    }) 
  }   
)
