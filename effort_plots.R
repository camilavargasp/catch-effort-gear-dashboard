
library(patchwork)
library(RColorBrewer)
area_cols <- 20
my_colors <- colorRampPalette(brewer.pal(8, "Set2"))(area_cols)
my_colors_2 <- colorRampPalette(brewer.pal(12, "Paired"))(area_cols)




effort_moment_plot <- function(gear_type,
                               effort_metric,
                               ordinate='slope_log',
                               input_data= catch_effort_data){

  mplot <- input_data %>%
    filter(GFWCategory==gear_type,
           effort_type==effort_metric) %>%
    mutate(fao_area_code = as.factor(fao_area_code)) %>%
    ggplot(aes(x = effort_moment, y = get(ordinate), label = iso3_code)) + ##label show in the display window when using ggplotly
    geom_point(aes(color = fao_area_code, size = n_vessel)) + #, shape = fao_area_code
    geom_text(aes(label = n_vessel), size = 2, check_overlap = T)+
    scale_color_manual(values = my_colors_2, name = "FAO Area Code")+
    scale_size(name = "Number of Vessels")+
    geom_smooth(aes(weight=n_vessel), method = "lm", se = FALSE, linetype = "dotted")+
    #geom_smooth(method = "lm", se = FALSE, linetype = "dotted", size=ifelse(weight_by_group, 0.5, 0))+
    #facet_wrap(~GFWCategory)+ #wrap vertically: ncol = 1
    theme_bw()+
    labs(title = gear_type)+
    ylab("log(effort/catch)")+ #
    xlab(paste("moment of", gsub('^.*_', '', effort_metric), sep=" "))+
    theme(legend.position = "right")

##ggplotly(mplot)
  return(mplot)

}

