###Fisheries info




gear_text <- function(info_data = fisheries_info,
                      country_input,
                      fishery_input){
  

  gear_use <- fisheries_info %>% 
        filter(country == country_input,
               fishery_name == fishery_input) %>%
        select(gear) %>%
        dplyr::distinct() %>%
        pull()
  
  return(gear_use)

}
