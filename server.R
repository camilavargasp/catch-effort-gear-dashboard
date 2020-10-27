library(shiny)
library(ggplot2) # load ggplot

function(input, output){
  

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





# fao_area_option <- switch(input$fao_areas,
#                           "Area 18" = 18,
#                           "Area 21" = 21,
#                           "Area 27" = 27,
#                           "Area 31" = 31,
#                           "Area 34" = 34,
#                           "Area 37" = 37,
#                           "Area 41" = 41,
#                           "Area 47" = 47,
#                           "Area 48" = 48,
#                           "Area 51" = 51,
#                           "Area 57" = 57,
#                           "Area 58" = 58,
#                           "Area 61" = 61,
#                           "Area 67" = 67,
#                           "Area 71" = 71,
#                           "Area 77" = 77,
#                           "Area 81" = 81,
#                           "Area 87" = 87,
#                           "Area 88" = 88)