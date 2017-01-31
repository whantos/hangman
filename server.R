#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotrix)
library(htmlTable)
#set up
load("hangman.rdata")

hangman.category <- ""
hangman.word <- ""
n <- 0
word.display <-""
number.mistakes <- 0
result.recorded <- FALSE
guess.messages <- ""
used.letters <- c()
first_call <- TRUE

new.game <- function() {
    # randomly select a word
    which.one <- round(runif(1,1,nrow(hangman)))
    hangman.category <<- hangman[which.one,"category"]
    hangman.word <<- hangman[which.one,"word"]
    n <<- nchar(hangman.word)
    
    # set other variables
    used.letters <<- c()
    number.mistakes <<- 0
    result.recorded <<- FALSE
    word.display <<-""
    guess.messages <<- ""
    first_call <<- TRUE
    
    for (i in seq(1:n)) {    
        if (!is.letter(substr(hangman.word,i,i))) {
            word.display <<- paste(word.display, substr(hangman.word,i,i), sep="")
        }
        else { word.display <<- paste(word.display,".",sep="") }
    }
}
is.letter <- function(x) (is.character(x) & grepl("[[:alpha:]]", x) & (nchar(x)==1))


guess <- function(letter) {
    guess.messages <<- ""
    
    if (!is.letter(letter)) {
        if(letter != " ")
            guess.messages <<-"You can only guess letters from the alphabet."
    }
    else if (toupper(letter) %in% used.letters) {
        guess.messages <<-paste("You've already used ",toupper(letter))
    }
    else {
        word.display.new <- ""
        found <- FALSE
        for (i in seq(1:n)) {
            if (tolower(substr(hangman.word,i,i)) == tolower(letter)) {
                word.display.new <- paste(word.display.new, substr(hangman.word,i,i), sep="")
                found <- TRUE
            }
            else { word.display.new <- paste(word.display.new, substr(word.display,i,i), sep="") }
        }
        
        word.display <<- word.display.new
        used.letters <<- c(used.letters,toupper(letter))
        if (found==FALSE) {
            number.mistakes <<- number.mistakes + 1
        }
    }
    
    if (number.mistakes >= 7) {
        guess.messages <<- "You have lost."
    }
    else if (word.display == hangman.word) {
        guess.messages <<- "You have won."
    }
}


new.game()


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
 
    observeEvent(input$text, {
      if(input$text != "" || first_call == TRUE) {
        first_call <<- FALSE
        guess(input$text)

        updateTextInput(session, "text", value = "")
        
        output$usedLetters <- renderText({
            
            letters <- matrix(c(LETTERS, c("","")), byrow = TRUE, nrow = 4)
            css <- rep("font-size: 3em;",26)
            css[match(isolate(used.letters), LETTERS)] <- "background: lightgrey; font-size: 3em;"
            css <- matrix(c(css,c("","")), byrow = TRUE, nrow = 4)
            
            htmlTable(letters,css.cell = css)
        })
        
        output$wordDisplay <- renderText({
            if (number.mistakes < 7) { 
                paste(hangman.category, ":    ", word.display, sep="") 
            }
            else { 
                paste(hangman.category, ":    ", hangman.word, sep="")
            }
        })
        
        output$gameMessage <- renderText( {
            guess.messages
        })
        
        output$distPlot <- renderPlot({
            
            ## Galgen
            plot(1:100,1:100, type="n", axes=F, xlab="", ylab="")
            rectFill(0,0,2,90,bg="brown",pch=NULL, fg="brown")
            rectFill(0,88,25,90,bg="brown",pch=NULL, fg="brown")
            segments(2,70,15,89,lwd=4, col = "brown")
            
            
            if(number.mistakes > 0) {
                ## Strick
                segments(25,81,25,90,lwd=2)
            }
            if(number.mistakes > 1) {
                ## Kopf
                draw.circle(25,70,5, border=1, lwd=2)
                draw.circle(23,73,1, border=1)
                draw.circle(27,73,1, border=1)
                draw.arc(25, 65, 2, deg1 = 0,deg2=180)
            }
            if(number.mistakes > 2) {
                segments(25,60,25,30,lwd=2)
            }
            if(number.mistakes > 3) {
                segments(25,55,30,40,lwd=2)
            }
            if(number.mistakes > 4) {
                segments(25,55,20,40,lwd=2)
                segments(25,55,30,40,lwd=2)
            }
            if(number.mistakes > 5) {
                
                segments(25,30,30,10,lwd=2)
            }
            if(number.mistakes > 6) {
                segments(25,30,20,10,lwd=2)
                segments(25,30,30,10,lwd=2)
            }
            
        })
        }
    })
  
    observeEvent(input$new_game, {
        new.game()
        updateTextInput(session, "text", value = " ")
    })

})


 
