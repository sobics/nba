#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(xml2)
library(dplyr)
library(DT)

box <- read.csv("../../Basketball Data/Player_Boxscores.csv", stringsAsFactors = FALSE)

#game1 <- box
#player1 <- box[1,""]

# Define server logic required to draw a histogram
print("in server")
shinyServer(function(input, output) {
  
  
  box_sub <- box %>% filter(Game_id == 20700001)
  print(box_sub)
  dont_show <- c('Game_id', 'Season', 'Season_Type', 'Game_No', 'Playoff_Rd', 'Playoff_Rd_Game_No', 
                     'Date', 'Person_id', 'Team_id', 'vs_team_id', 'Min_Played', 'Sec_Played',
                     'Offensive_Rebounds', 'Defensive_Rebounds', 'Technical_Fouls', 'Flagrant_Fouls', 
                     'Ejections', 'Points_In_Paint', 'Fast_Break_Points', 'Triple_Doubles', 
                     'Double_Doubles', 'Blocks_Against', 'Pts_Off_TOs', 'Second_Chance_PTS')
  dont_show_ind <- which(names(box) %in% dont_show)
  print(dont_show_ind)
  
  output$boxscore <- renderDataTable({
    
    #nba traditional box score contains (in order):
    #Home Name:
      #Player name, mm:ss, FGM, FGA, FG%,	3PM, 3PA,	3P%, FTM,	FTA, FT%,	OREB, DREB, REB, AST, TOV, STL, BLK, PF, PTS, +/-
      #Team totals
    #Away Name:
      #same
    
    datatable(
      data = box_sub,
      options = list(
        list(targets = dont_show_ind, visible = TRUE)
      )
    )
    
  })
  print("done!")
  
})
