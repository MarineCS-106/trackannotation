csv_to_rast <- function(csv_path) {
  sst_df <- read_csv(csv_path, skip = 1) %>% 
    select(2, 1, 3) %>% 
    set_names(c("lon", "lat", "sst"))
  
  ep_sst <- rast("data/ep_sst.tiff")
  ep_ext <- ext(project(ep_sst, "epsg:4326"))
  
  sst_df %>% 
    filter(lon >= ep_ext[1],
           lon <= ep_ext[2],
           lat >= ep_ext[3],
           lat <= ep_ext[4]) %>% 
    rast(crs = "epsg:4326",
         extent = ep_ext) %>% 
    project(crs(ep_sst))
}
