library(shiny)
library(tidyverse)
library(plotly)

source("effort_plots.R")

fao_area_name <- c("Area 18",
                   "Area 21",
                   "Area 27",
                   "Area 31",
                   "Area 34",
                   "Area 37",
                   "Area 41",
                   "Area 47",
                   "Area 48",
                   "Area 51",
                   "Area 57",
                   "Area 58",
                   "Area 61",
                   "Area 67",
                   "Area 71",
                   "Area 77",
                   "Area 81",
                   "Area 87",
                   "Area 88")


# Define UI for catch effort
fluidPage(
  
  titlePanel("Catch Effort Relationship by Fishing Gear Type"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("Explore the relationship between fisheries catch and vessels' effort in different FAO fishing areas"),
      
      selectInput("gear", 
                  label = "Choose a fishing gear",
                  choices = c("Drifting Longlines", 
                              "Pole and Line", 
                              "Pots and Traps", 
                              "Seiners", 
                              "Trawlers", 
                              "Set Longlines", 
                              "Driftnets", 
                              "Dredge Fishing", 
                              "Set Gillnets", 
                              "Other Fishing", 
                              "Trollers")),
      selectInput("metric", 
                  label = "Choose an effort metric",
                  choices = c("Vessel Length (m)",
                              "Vessel Tonnage (gt)",
                              "Vessel Engine Power (kw)"),
                  selected = "Vessel Engine Power (kw)"),
      
      selectInput("plot_type",
                  label = "Selecet the type of plot you want to see",
                  choices = c("Multi-Panes (by FAO Areas)" = "facet",
                              "One plot (all FAO Areas)" = "one_plot"))
   
   
    ),
    
    mainPanel(
      
      h3("Results"),
      
      plotlyOutput("catch_effort_plot",
                   height = "600px"),
      
      plotlyOutput("catch_effort_facet",
                   height = "800px")
      
      
    )
  )
)