#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hangman"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
      column(4,
             

       textInput("text", label = h2("Guess:"), 
                 value = ""),
       h2("Used Letters:"),
       htmlOutput("usedLetters"),
       actionButton("new_game", "new Game")
    ),
    
    # Show a plot of the generated distribution
    column(8,
       htmlOutput("wordDisplay"),
       plotOutput("distPlot"),
       htmlOutput("gameMessage")
    )),
  fluidRow(
    column(12,
           h3("How to play"),
           p("You have to guess a random word.",br(),
            "Type a letter in the text field. If you gess right, the letter appears in the word, if you guess wrong ... u will see.",br(),
            "After the seventh wrong guess, you have lost.",br(),
            "You can start a new game by pressing the \"new Game\" button."),
           p("This application has been inspired by Marek Hlavac (Political Economy and Government, Harvard University).",br(), 
                   "The original can be found here: ",a("https://sites.google.com/site/marekhlavac/computer-games-written-in-r"))
           )
  )
))
