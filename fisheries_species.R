### Species Allocation by fishery fx



fisheries_info <- read_csv("data/fao_fisheries_norm_bk.csv")

species_by_fishery <- function(country_name, 
                               fishery, 
                               fisheries_data = fisheries_info) {
  
  
  species_alocation <- fisheries_data %>% 
    filter(country == country_name,
           fishery_name == fishery) %>% 
    select(spp_common, fao_area, pct)
  
}

##FIX: Function is not working!
## ADD:Box Reporting Gear associates to Fishery