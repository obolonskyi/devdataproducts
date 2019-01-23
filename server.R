setwd("C:/Users/mobol/Downloads")
library(shiny)
library(leaflet)
library(maps)
library(mapproj)
source("helpers.R")


pollution_data <- read.csv("pollution_2016.csv", header=TRUE, stringsAsFactors=FALSE)

NO2agg <- aggregate(x = pollution_data$NO2.Mean, by = list(pollution_data$County), FUN = mean)
O3agg <-aggregate(x = pollution_data$O3.Mean, by = list(pollution_data$County), FUN = mean)
SO2agg <- aggregate(x = pollution_data$SO2.Mean, by = list(pollution_data$County), FUN = mean)
COagg <- aggregate(x = pollution_data$CO.Mean, by = list(pollution_data$County), FUN = mean)

shinyServer(function(input, output) {
   
  output$map <- renderPlot({
    
    args <- switch(input$var,
                  "NO2" = list(NO2agg$x, "darkgreen", "% NO2"),
                   "O3" = list(O3agg$x,  "blue", "% O3"),
                   "SO2" = list(SO2agg$x,  "black", "% SO2"),
                   "CO" = list(COagg$x,  "red", "% CO"))
    
    args$min <- input$range[1]
    args$max <- input$range[2]
    
    do.call(percent_map, args)
    
    })
})
