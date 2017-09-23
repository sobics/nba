library(xml2); library(dplyr)
setwd("C:/Users/Nathaniel Brown/Documents/important things/nbahack2017")
datafolder <- "sportvu1"
datafile <- "NBA_LG_FINAL_SEQUENCE_OPTICAL$2016110103_Q4.xml"
dataname <- paste0(datafolder, "/", datafile)

readXML <- function(filename){
  opticalxml <- read_html(paste0(filename))
  opticaldf <-  xml_find_all(opticalxml, ".//moment") %>% 
                xml_attrs(c("time", "locations", "game-clock", "shot-clock", "game-event-id")) %>%
                as.data.frame(stringsAsFactors=FALSE) %>% t() %>% as.data.frame(stringsAsFactors=FALSE)
  return(opticaldf)
}

rownames(opticaldf) <- NULL

to_mat <- function(lst, namez){
  df <- lapply(lst, function(x){strsplit(x,",")}) %>% data.frame() %>% t()
  colnames(df) <- namez
  rownames(df) <- NULL
  return(df)
}

clean_optical <- function(optical){
  #names(optical) <- lapply(strsplit(names(optical),'...', fixed= TRUE), function(x){x[2]}) %>% as.character()
  
  name <- c("team_id", "player_id", "y", "x", "z")
  loc <- optical[,"locations"]
  loc <- strsplit(loc, ";")
  
  ball <- lapply(loc, '[', 1) %>% to_mat(name)
  p1 <- lapply(loc, '[', 2) %>% to_mat(name)
  p2 <- lapply(loc, '[', 3) %>% to_mat(name)
  p3 <- lapply(loc, '[', 4) %>% to_mat(name)
  p4 <- lapply(loc, '[', 5) %>% to_mat(name)
  p5 <- lapply(loc, '[', 6) %>% to_mat(name)
  p6 <- lapply(loc, '[', 7) %>% to_mat(name)
  p7 <- lapply(loc, '[', 8) %>% to_mat(name)
  p8 <- lapply(loc, '[', 9) %>% to_mat(name)
  p9 <- lapply(loc, '[', 10) %>% to_mat(name)
  p10 <- lapply(loc, '[', 11) %>% to_mat(name)
  
  optical[["ball_x"]] <- ball[,"x"] 
  optical[["ball_y"]] <- ball[,"y"] 
  optical[["ball_z"]] <- ball[,"z"] 
  
  optical[["p1_global_id"]] <- p1[,"player_id"]
  optical[["p1_team_id"]] <- p1[,"team_id"]
  optical[["p1_x"]] <- p1[,"x"] 
  optical[["p1_y"]] <- p1[,"y"] 
  
  optical[["p2_global_id"]] <- p2[,"player_id"]
  optical[["p2_team_id"]] <- p2[,"team_id"]
  optical[["p2_x"]] <- p2[,"x"] 
  optical[["p2_y"]] <- p2[,"y"] 
  
  optical[["p3_global_id"]] <- p3[,"player_id"]
  optical[["p3_team_id"]] <- p3[,"team_id"]
  optical[["p3_x"]] <- p3[,"x"] 
  optical[["p3_y"]] <- p3[,"y"] 
  
  optical[["p4_global_id"]] <- p4[,"player_id"]
  optical[["p4_team_id"]] <- p4[,"team_id"]
  optical[["p4_x"]] <- p4[,"x"] 
  optical[["p4_y"]] <- p4[,"y"] 
  
  optical[["p5_global_id"]] <- p5[,"player_id"]
  optical[["p5_team_id"]] <- p5[,"team_id"]
  optical[["p5_x"]] <- p5[,"x"] 
  optical[["p5_y"]] <- p5[,"y"] 
  
  optical[["p6_global_id"]] <- p6[,"player_id"]
  optical[["p6_team_id"]] <- p6[,"team_id"]
  optical[["p6_x"]] <- p6[,"x"] 
  optical[["p6_y"]] <- p6[,"y"] 
  
  optical[["p7_global_id"]] <- p7[,"player_id"]
  optical[["p7_team_id"]] <- p7[,"team_id"]
  optical[["p7_x"]] <- p7[,"x"] 
  optical[["p7_y"]] <- p7[,"y"] 
  
  optical[["p8_global_id"]] <- p8[,"player_id"]
  optical[["p8_team_id"]] <- p8[,"team_id"]
  optical[["p8_x"]] <- p8[,"x"] 
  optical[["p8_y"]] <- p8[,"y"] 
  
  optical[["p9_global_id"]] <- p9[,"player_id"]
  optical[["p9_team_id"]] <- p9[,"team_id"]
  optical[["p9_x"]] <- p9[,"x"] 
  optical[["p9_y"]] <- p9[,"y"] 
  
  optical[["p10_global_id"]] <- p10[,"player_id"]
  optical[["p10_team_id"]] <- p10[,"team_id"]
  optical[["p10_x"]] <- p10[,"x"]
  optical[["p10_y"]] <- p10[,"y"]
  
  optical[["locations"]] <- NULL
  rm(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, ball, loc)
  
  optical <- apply(optical,2,as.numeric)
  optical <- as.data.frame(optical)
  return(optical)
}

sportvu_to_df <- function(filename){
  readXML(filename) %>% clean_optical()
}
