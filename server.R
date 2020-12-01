library(shiny)
library(ggplot2) # load ggplot



function(input, output, session){
  
  observe({
    updateSelectInput(session, 
                      "fishery_fishery", 
                      choices = fisheries_info[fisheries_info$country == input$country_fishery, "fishery_name"]) ##to ba able to select only the fisheries within the selected country
  })
       
  output$species_table_title <- renderText({ 
    ##If reactive title is what we want we call the objects in the ui
    # paste0("Species in ", input$fishery_fishery, " in " , input$country_fishery)
    "Species Allocation"
    
  })
  
  
  output$species_table <- renderTable({
    
species_alocation <- fisheries_info %>% 
      filter(country == input$country_fishery,
             fishery_name == input$fishery_fishery) %>% 
      select("Species Common Name" = spp_common, "% of catch allocated to fishery" = pct)
    
  })
  
  output$fishery_info_table_title <- renderText(
    "Fisheries Facts"
  )
  
  output$fishery_info_table <- renderTable({
    
    fishery_facts <- fisheries_info %>% 
      filter(country == input$country_fishery,
             fishery_name == input$fishery_fishery) %>% 
      select("Gear" = gear_name, "Vessel Length" = vessel_length, "Fishing Depth" = depth, "FAO fishing Area"= fao_area, "Fisheries Sector" = fisheries_sector) %>% 
    distinct()
    
  })
  
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
  
  
  
  }


# output$fao_area_box <- renderInfoBox({
#   
#   fishing_area <- fisheries_info %>% 
#     filter(country == input$country_fishery,
#            fishery_name == input$fishery_fishery) %>% 
#     select(fao_area) %>% 
#     dplyr::distinct() %>% 
#     pull()
#   
#   infoBox(
#     "FAO Fishing Area", paste0(fishing_area), icon = icon("list"),
#     color = "purple")
#   })
# 
# output$fao_area_box <- renderInfoBox({
#   
#   gear_use <- fisheries_info %>% 
#     filter(country == input$country_fishery,
#            fishery_name == input$fishery_fishery) %>% 
#     select(gear) %>% 
#     dplyr::distinct() %>% 
#     pull()
#   
#   infoBox(
#     "Gear", paste0(gear_use) , icon = icon("thumbs-up", lib = "glyphicon"),
#     color = "yellow"
#   )
# })