library(shiny)
library(ggplot2) # load ggplot

function(input, output, session){
  

  output$catch_effort_plot <- renderPlotly({
    
    gear_option <- switch(input$gear,
                          "Drifting Longlines" = "drifting_longlines", 
                          "Pole and Line" = "pole_and_line", 
                          "Pots and Traps" = "pots_and_traps", 
                          "Seiners" =  "seiners", 
                          "Trawlers" = "trawlers", 
                          "Set Longlines" = "set_longlines", 
                          "Driftnets" = "driftnets", 
                          "Dredge Fishing" = "dredge_fishing", 
                          "Set Gillnets" = "set_gillnets", 
                          "Other Fishing" = "other_fishing", 
                          "Trollers" = "trollers")
    
    metric_option <- switch(input$metric,
                            "Vessel Length (m)" = "total_f_hours_length",
                            "Vessel Tonnage (gt)" = "total_f_hours_tonnage",
                            "Vessel Engine Power (kw)" = "total_f_hours_kw")
   
    
     if(input$plot_type == "one_plot"){
    
    effort_moment_plot(gear_type = gear_option,
                       effort_metric = metric_option,
                       ordinate='slope_log',
                       input_data= catch_effort_data)
     } else {
       effort_moment_fao_plot(gear_type = gear_option,
                              effort_metric = metric_option,
                              ordinate='slope_log',
                              input_data= catch_effort_data)
     }
  })

  observe({
    updateSelectInput(session, 
                      "fishery_fishery", 
                      choices = fisheries_info[fisheries_info$country == input$country_fishery, "fishery_name"])
  })
       
  output$species_table <- renderTable({
    
    species_by_fishery(country_name = country_fishery, 
                       fishery = fishery_fishery)
    
  })
     
  }


