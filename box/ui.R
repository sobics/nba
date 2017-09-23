#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(xml2)
library(dplyr)

#print(list.files("../../Basketball Data/"))

#print(head(read.csv("../../Basketball Data/Player_Boxscores.csv", stringsAsFactors = FALSE)))
print("in ui")
shinyUI(fluidPage(
   
   selectInput(inputId = "gameid",
               label = "Select a Game",
               choices = 1:10),
  
  tableOutput("boxscore")
  
  
  # Show a plot of the generated distribution
))
