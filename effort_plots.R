
library(patchwork)
library(RColorBrewer)
area_cols <- 20
my_colors <- colorRampPalette(brewer.pal(8, "Set2"))(area_cols)
my_colors_2 <- colorRampPalette(brewer.pal(12, "Paired"))(area_cols)


catch_effort_data <- read_csv("data/catch_effort_long.csv")

effort_moment_plot <- function(gear_type,
                               effort_metric,
                               #fao_areas,
                               ordinate='slope_log',
                               input_data= catch_effort_data){

  mplot <- input_data %>%
    filter(GFWCategory == gear_type,
           effort_type == effort_metric) %>% #fao_area_code %in% fao_areas
    mutate(fao_area_code = as.factor(fao_area_code)) %>%
    ggplot(aes(x = effort_moment, 
               y = get(ordinate), 
               label = iso3_code)) + ##label show in the display window when using ggplotly
    geom_point(aes(color = fao_area_code, 
                   size = n_vessel)) + #, shape = fao_area_code
    geom_text(aes(label = n_vessel), 
              size = 2, 
              check_overlap = T)+
    scale_color_manual(values = my_colors_2,
                       name = "FAO Area Code")+
    #scale_size(name = "Number of Vessels")+
    geom_smooth(aes(weight=n_vessel), method = "lm", se = FALSE, linetype = "dotted")+
    #geom_smooth(method = "lm", se = FALSE, linetype = "dotted", size=ifelse(weight_by_group, 0.5, 0))+
    theme_bw()+
    #labs(title = gear_type)+
    ylab("log(effort/catch)")+ #
    xlab(paste("moment of", gsub('^.*_', '', effort_metric), sep=" "))
    #theme(legend.position = "bottom")

p <- ggplotly(mplot) 
# %>% 
#   layout(legend = list(orientation = "h",   # show entries horizontally
#                        xanchor = "center",  # use center of legend as anchor
#                        x = 0.5))             # put legend in center of x-axis

return(p)

}

effort_moment_fao_plot <- function(gear_type,
                                   effort_metric,
                                   input_data=catch_effort_data,
                                   ordinate = "slope_log") {
  
  filt_data <- input_data %>%
    filter(GFWCategory == gear_type,
           effort_type == effort_metric) %>%
    mutate(fao_area_code = as.factor(fao_area_code),
           ord = get(ordinate))
  
  model <- lm(ord ~ effort_moment, data=filt_data)
  
  fao_mplot <- filt_data %>% ggplot()+
    geom_smooth(method = "lm", se = TRUE, linetype = "dotted", # inherit.aes = FALSE,
                data = model, aes(x = effort_moment, y = ord))+
    geom_point(aes(x = effort_moment,
                   y = ord, color = fao_area_code, size = n_vessel)) + #, shape = fao_area_code
    geom_text(aes(x = effort_moment, y = ord, label = n_vessel), size = 2, check_overlap = T)+
    scale_color_manual(values = my_colors_2, name = "FAO Area Code")+
    scale_size(name = "Number of Vessels")+
    facet_wrap(~fao_area_code)+ #wrap vertically: ncol = 1
    theme_bw()+
    labs(title = paste0("Effort - Catch relationship for ", gear_type))+
    ylab("log(effort/catch)")+
    xlab(paste("moment of", gsub('^.*_', '', effort_metric), sep=" "))+
    theme(legend.position = "right")
  
  #plot(fao_mplot)
  return(fao_mplot)
  
}