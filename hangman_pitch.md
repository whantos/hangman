Coursera Project - Creating a Shiny Web Application
========================================================
author: Karl-Heinz Reisenauer
date: 01.02.2017
autosize: true


The Idea
========================================================

# A small game between the hard work promotes the quality

In the spirit of this idea, I found a hangman game written in R by Marek Hlavac. 

Excited from this idea, I also wanted to create such a mini game as a Shiny Application ...  

The idea for this project was born.


The Data
========================================================

*The most important thing for such a game is the game data*

Fortunately, Marek Hlavac already has a nice collection of words to guess, including the category as a reference.  

They are all found in the file "hangman.rdata", which I used as the basis for the application


```r
load("hangman.rdata")
hangman$category <- as.factor(hangman$category)
str(hangman)
```

```
'data.frame':	1291 obs. of  2 variables:
 $ category: Factor w/ 13 levels "animal","article of clothing",..: 6 6 6 6 6 6 6 6 6 6 ...
 $ word    : chr  "Afghanistan" "Albania" "Algeria" "Andorra" ...
 - attr(*, "var.labels")= chr  "Category" "Word"
```

The small survey shows that there are 1291 words in 13 categories to guess.  
So there is plenty of variety

The Game
========================================================

Of course, it needs an appealing GUI and top graphics to increase the guessing fun and to offer the player a great playing experience.

![of course you have to guess right to win](lost_game.png)

So that the user keeps the overview, all already used letters are marked.  
To guess, only one letter must be entered into the text field.  
A new game can be started at any time by clicking the "new game" Button.  
Of course you have to guess right to win ...


Are you interested? 
========================================================

## Play the Game here <https://whantos.shinyapps.io/Hangman/>  
## Get the Code here <https://github.com/whantos/hangman>  
  
  

*Thanks to Marek Hlavac, who has shown that you can have fun with R not only with statistical ways.*


The original can be found here:
<https://sites.google.com/site/marekhlavac/computer-games-written-in-r>

