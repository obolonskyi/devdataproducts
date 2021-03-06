shiny_presentation_2
========================================================
author: Misha Obolonskyi
date: 24 Jan 2019
autosize: true

 Project - Level of pollution in the US
========================================================

Current project takes the data from file with pollution metrics from the US in 2016 and plot it on the map. 
There are four types of pollution. Data is collected on the city level daily but averaged and aggregated to the county level on the yearly basis.

Pollution types
========================================================

- NO2
- O3
- SO2
- CO

## UI.R Code
========================================================

```r
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Average pollution level in the US in 2016"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("var", label = "Chose type of pollution",
                   choices = c("NO2", "O3", "SO2","CO"),
                   selected = "NO2")
    ),
    
    # Show a plot of the generated distribution
  mainPanel(plotOutput("map"))
    )
  )
)
```

## Server.R code
========================================================

```r
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
```
