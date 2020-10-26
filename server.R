library(shiny)
library(ggplot2) # load ggplot

function(input, output){
  
  output$catch_effort_plot <- renderPlot({
    effort_moment_plot(gear_type = "gear",
                       effort_metric = "total_f_hours_kw",
                       ordinate='slope_log',
                       input_data= catch_effort_data)
  })
}