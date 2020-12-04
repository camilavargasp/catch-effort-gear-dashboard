

## Grear names to be displayed in tables
gear_mapping <- read_csv(here::here("data/master_gear_mapping.csv")) %>% 
  select(gear = GilmanGear25Code, gear_name = GilmanGear25Description) %>% 
  distinct()

## Note: Fishing sector is determine by us following the conditions decribed in the following code
fisheries_info <- read_csv(here::here("data/fao_fisheries_norm.csv")) %>% 
  mutate_at(c("vessel_length", "depth", "location"), replace_na, "no information") %>% 
  left_join(gear_mapping, by = "gear") %>% 
  mutate(
    productive_sector = case_when(
      str_detect(fishery_name, "Industrial") ~ "industrial",
      str_detect(fishery_name, "Artisanal") ~ "small_scale",
      str_detect(fishery_name, "industrial") ~ "industrial",
      str_detect(fishery_name, "artisanal") ~ "small_scale",
      T ~ "none")) %>% 
  mutate(fisheries_sector = case_when(
    productive_sector == "small_scale" ~ "non-industrial",
    vessel_length %in% c("<10 m", "<10m") & productive_sector == "no information" ~ "non-industrial",
    location == "Inshore" & productive_sector == "none" ~ "non-industrial",
    vessel_length == "No Vessels" ~ "non-industrial",
    vessel_length %in% c("10-24 m", "10 - 24 m", "10- 24 m") & productive_sector == "no information" & location =="no information" ~ "non-industrial",
    gear == "MIS" ~ "non-industrial",
    TRUE ~ "industrial"))


## Fisheries in each GFW Vessel Category
fisheries_gfw_cat <- read_csv(here::here("data/fisheries_in_gfw_cat.csv")) %>% 
  select(year, fao_landing_c_name, fao_area_code, depth, location, vessel_length, fishery_name, GFWCategory) %>% 
  mutate_at("depth", replace_na, "no information") %>% 
  mutate(location = case_when(location == "none" ~ "no information",
                              T ~ location),
         vessel_length = case_when(vessel_length == "none" ~ "no information",
                                   T ~ vessel_length))
