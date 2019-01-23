


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