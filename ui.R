library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(here)

source(here::here("effort_plots.R"))
source(here::here("data_prep.R"))


# Setting up the dashboard page
dashboardPage(
  
  ##title
  dashboardHeader(
    title = "Fishing Gear Plastic Project",
    titleWidth = 300
  ),
  
  dashboardSidebar(
    sidebarMenu(
      ## This defines the order of the tabs
      menuItem("Fisheries by Country", tabName = "fisheries_country"),
      menuItem("Industrial Fisheries Effort", tabName = "industrial_effort"),
      menuItem("Catch-Effort Relationship", tabName = "catch_effort")
    )
  ),
  
  ##The content of each of the sidebar options
  dashboardBody(
    tabItems(
      
   ##First tab content - Fisheries Info
      tabItem(tabName = "fisheries_country",
              h2("Fisheries Information by Country"),
              h3("Learn about a fishery by selecting a country and a fishery within that territory"),
            fluidRow(
              box(
                selectInput("country_fishery",
                            label = "Select a Country",
                            choices = unique(fisheries_info$country)),
                selectInput("fishery_fishery",
                            label = "Select a Fishery",
                            choices = unique(fisheries_info$fishery_name)),
                width = 4),
              
              box(
                h3(
                  textOutput("fishery_info_table_title")
                ),

                tableOutput("fishery_info_table"),
                width = 8),
             
               box(
                
                h3(
                  textOutput("species_table_title")
                ),
          
                tableOutput("species_table"),
                width = 8)
           ),
           
      ),
    
      
      ##Second tab content - Industrial Fisheries Effort
      tabItem(tabName = "industrial_effort",
              h2("Industrial Fisheries Effort Allocation"),
              h3("Learn about effort allocation per gear type for each country"),
              fluidRow(
                box(
                  selectInput("year_industrial",
                              label = "Select a year",
                              choices = unique(fisheries_gfw_cat$year)),
                  selectInput("country_industrial",
                              label = "Select a country",
                              choices = unique(fisheries_gfw_cat$fao_landing_c_name)),
                  selectInput("gfw_gear_industrial)",
                              label = "Select gear type",
                              choices = unique(fisheries_gfw_cat$GFWCategory)),
                  width = 4),
                
                
                box(
                  
                  h3(
                    textOutput("gfw_fishery_table_title")
                  ),
                  
                  tableOutput("gfw_fishery_table"),
                  width = 8),
              
              box(
                
                h3(
                  textOutput("effort_metric_table_title")
                ),
                
                tableOutput("effort_metric_table"),
                width = 8)
              ),
      ),
      
        ##Third tab content - catch effort plots
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
                       width = 8)
                     
                   )
        
      )
    )
  )
)

