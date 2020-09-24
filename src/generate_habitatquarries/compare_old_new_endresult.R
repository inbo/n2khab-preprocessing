# Huidige afspraken:
# 1. Steven werkt shapefile verder af:
#   - opsplitsen grensoverschrijdend 8310
#   - nummering van polygon_id: opnieuw maken (1 tot 44), op basis van gesorteerd naamveld
#   - nummering van unit_id: kan worden hernummerd door:
#     1. gelijkstellen aan polygon_id
#     2. mergen van sommige nummers waar meerdere polygon_id's één populatie-eenheid zijn. Dus die grensoverschrijdende.
# 2. Floris zet shapefile om naar geopackage (kolomnamen goedzetten, lege strings 'missing' maken, bibliografie als een niet-spatiale tabel toevoegen)
# 3. Steven publiceert op Zenodo



filepath <- file.path(datapath, "habitatquarries_previous.gpkg")
habitatquarries_test <-
  read_sf(filepath,
          layer = "habitatquarries")

drive_auth(email = TRUE)
drive_ls(as_id("14MGdxHtxe8VGaCu70Y8Pmc0jusZgpym9")) %>%
  filter(str_detect(name, "habitatquarries_v2_20200917")) %>%
  {map2(.$name, .$id, function(name, id) {
    drive_download(as_id(id),
                   path = file.path(tempdir(), name),
                   overwrite = TRUE)
  })} %>%
  invisible()

filepath_new <- file.path(tempdir(), "habitatquarries_v2_20200917.shp")
st_layers(filepath_new)
(habitatquarries_new <-
  read_sf(filepath_new))

# polygon_id

habitatquarries_test %>%
  st_drop_geometry %>%
  count(polygon_id) %>% filter(n > 1)

# non-unique:
habitatquarries_new %>%
  st_drop_geometry %>%
  count(polygon_id) %>% filter(n > 1)

# unit_id

habitatquarries_test %>%
  st_drop_geometry %>%
  count(unit_id) %>% as.data.frame

habitatquarries_new %>%
  st_drop_geometry %>%
  count(unit_id) %>% as.data.frame


# name coincidence

habitatquarries_test %>%
  st_drop_geometry %>%
  count(name) %>%
  full_join(habitatquarries_new %>%
              st_drop_geometry %>% count(name),
            by = "name") %>%
  arrange(name) %>%
  View("names")

# unit_id + name coincidence

habitatquarries_test %>%
  st_drop_geometry %>%
  count(name, unit_id) %>%
  full_join(habitatquarries_new %>%
              st_drop_geometry %>% count(name, unit_id),
            by = "name") %>%
  arrange(name) %>%
  View("unit_names")

# type + name coincidence

habitatquarries_test %>%
  st_drop_geometry %>%
  count(name, unit_id, habitattype) %>%
  full_join(habitatquarries_new %>%
              st_drop_geometry %>% count(name, unit_id, habitattyp),
            by = "name") %>%
  arrange(name) %>%
  View("habtype_names")

# extra_reference coincidence

habitatquarries_test %>%
  st_drop_geometry %>%
  count(extra_reference) %>%
  full_join(habitatquarries_new %>%
              st_drop_geometry %>% count(extra_refe),
            by = c("extra_reference" = "extra_refe")) %>%
  arrange(extra_reference) %>%
  View("sources")


# missing habtype = outside Flanders?

provinces_path <- find_root_file("n2khab_data/10_raw/provinces",
                                 criterion = has_dir("n2khab_data"))
provinces <-
  read_sf(provinces_path, crs = 31370)
zoom <- coord_sf(datum = st_crs(31370),
                 xlim = c(234e3, 244e3),
                 ylim = c(163e3, 169.2e3))
bbox1 <- st_bbox(habitatquarries_test)
ggplot() +
  geom_sf(data = habitatquarries_new %>% filter(habitattyp == "8310"),
          colour = "black",
          aes(fill = `habitattyp`)) +
  geom_sf(data = provinces, fill = NA, colour = "purple") +
  zoom +
  # coord_sf(datum = st_crs(31370),
  #          xlim = bbox1$xlim + c(-2e3, 2e3),
  #          ylim = bbox1$ylim + c(-2e3, 2e3)) +
  theme_bw() +
  theme(legend.position = "bottom")
ggplot() +
  geom_sf(data = habitatquarries_new %>% filter(habitattyp == "gh"),
          colour = NA,
          aes(fill = `habitattyp`)) +
  geom_sf(data = provinces, fill = NA, colour = "purple") +
  zoom +
  # coord_sf(datum = st_crs(31370),
  #          xlim = bbox1$xlim + c(-2e3, 2e3),
  #          ylim = bbox1$ylim + c(-2e3, 2e3)) +
  theme_bw() +
  theme(legend.position = "bottom")

ggplot() +
  geom_sf(data = habitatquarries_new %>% filter(is.na(habitattyp)),
          colour = NA,
          fill = "grey70") +
  geom_sf(data = provinces, fill = NA, colour = "purple") +
  zoom +
  # coord_sf(datum = st_crs(31370),
  #          xlim = bbox1$xlim + c(-2e3, 2e3),
  #          ylim = bbox1$ylim + c(-2e3, 2e3)) +
  theme_bw() +
  theme(legend.position = "bottom")


# checking reasoning of units with multiple polygons & of unit_id > 100

habitatquarries_new %>%
  st_drop_geometry %>%
  count(unit_id) %>%
  filter(n > 1) %>%
  semi_join(habitatquarries_new, ., by = "unit_id") %>%
  # st_drop_geometry %>%
  # count(unit_id, name)
        #   # A tibble: 7 x 3
        #   unit_id name                           n
        # <dbl> <chr>                      <int>
        # 1     100 De Keel                        2
        # 2     102 Kleine Keel                    2
        # 3     103 Muizenberg                     3
        # 4     104 Ternaaien beneden              2
        # 5     105 Ternaaien boven                2
        # 6     106 Caestert                       2
        # 7     107 Roosburg - Drie-dagen-berg     2
  ggplot() +
  geom_sf(colour = "green",
          aes(fill = `habitattyp`)) +
  geom_sf(data = provinces, fill = NA, colour = "purple") +
  zoom +
  # coord_sf(datum = st_crs(31370),
  #          xlim = bbox1$xlim + c(-2e3, 2e3),
  #          ylim = bbox1$ylim + c(-2e3, 2e3)) +
  theme_bw() +
  theme(legend.position = "bottom")

habitatquarries_new %>%
  st_drop_geometry %>%
  count(unit_id) %>%
  filter(n == 1, unit_id >= 100) %>%
  semi_join(habitatquarries_new, ., by = "unit_id") %>%
  # st_drop_geometry %>%
  # count(unit_id, name)
        #   # A tibble: 1 x 3
        #   unit_id name                 n
        # <dbl> <chr>            <int>
        #   1     101 De Keel - Balkon     1
  ggplot() +
  geom_sf(colour = "green",
          aes(fill = `habitattyp`)) +
  geom_sf(data = provinces, fill = NA, colour = "purple") +
  # zoom +
  coord_sf(datum = st_crs(31370),
           xlim = c(240e3, 241e3),
           ylim = c(168e3, 169e3)) +
  theme_bw() +
  theme(legend.position = "bottom")

habitatquarries_new %>%
  st_drop_geometry %>%
  filter(str_detect(name, "Keel"))
    # # A tibble: 5 x 6
    # fid_ polygon_id unit_id name             habitattyp extra_refe
    # <dbl>      <dbl>   <dbl> <chr>            <chr>      <chr>
    #   1     0         13     100 De Keel          8310       Walschot 2010
    # 2     0         14     100 De Keel          NA         Walschot 2010
    # 3     0         18     102 Kleine Keel      8310       Walschot 2010
    # 4     0         19     102 Kleine Keel      NA         Walschot 2010
    # 5     0         45     101 De Keel - Balkon 8310       Walschot 2010


# how are polygon_ids and unit_ids sorted?

habitatquarries_new %>%
  st_drop_geometry %>%
  arrange(name, polygon_id) %>%
  View("arranged")

habitatquarries_new %>%
  st_drop_geometry %>%
  arrange(unit_id >= 100, name, polygon_id) %>%
  select(polygon_id, unit_id, name) %>%
  kable

