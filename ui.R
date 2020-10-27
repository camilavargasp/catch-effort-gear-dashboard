library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

source("effort_plots.R")


# Setting up the dashboard page
dashboardPage(
  
  ##title
  dashboardHeader(
    title = "Fishing Gear Plastic Project",
    titleWidth = 300
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Catch-Effort Relationship", tabName = "catch_effort"),
      menuItem("Fisheries Information", tabName = "fisheries_info")
    )
  ),
  
  ##The content of each of the sidebar options
  dashboardBody(
    tabItems(
      
      ##First tab content - Catch effort plots
      tabItem(tabName = "catch_effort",
              h2("Catch Effort Relationship by Fishing Gear Type"),
              h4("Explore the relationship between fisheries catch and vessels' effort in different FAO fishing areas"),
            
            fluidRow(
              box(
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
                                        "One plot (all FAO Areas)" = "one_plot")),
                width = 4),
        
                
                box(
                  h3("Results"),
                  
                  plotlyOutput("catch_effort_plot",
                               height = "600px"),
                  
                  plotlyOutput("catch_effort_facet",
                               height = "800px"),
                  width = 8),
                 
             )
            ),
      
      ##Second tab content - Fisheries Info
      tabItem(tabName = "fisheries_info",
              h2("Fisheries Information by Country")
              )
    )
  )
)  

