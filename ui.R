library(shiny)
library(tidyverse)

source("effort_plots.R")

# Load data
catch_effort_data <- read_csv("data/catch_effort_long.csv")


# Define UI for catch effort
fluidPage(
  
  titlePanel("Catch Effort Relationship by Fishing Gear Type"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("Explore the relationship between fisheries catch and vessels effort in different FAO fishing areas"),
      
      selectInput("gear", 
                  label = "Choose a fishing gear",
                  choices = unique(catch_effort_data$GFWCategory),
                  selected = "trawlers"),
         
    ),
    mainPanel(
      
      h2("Results"),
      plotOutput("catch_effort_plot")
      
    )
  )
)