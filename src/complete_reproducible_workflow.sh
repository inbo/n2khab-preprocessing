## This R script lists the steps in order, required to RE-generate processed
## (large or binary) data in the 'n2khab_data/20_processed'
## subfolder. It requires the RAW binary data to be present in the
## 'n2khab_data/10_raw' subfolder in the specified way (for further information,
## run: vignette("v020_datastorage", package = "n2khab")).

## Note on the relative paths: this script is supposed to be run from
## the root of the n2khab-preprocessing repository. Advice: simply run it from the
## n2khab-preprocessing.Rproj RStudio project.

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
## WARNING ! This script may take a very LONG time to run. You are advised
## to have a closer look into the sourced files: do you really want to reproduce
## everything?
## For mere usage, the resulting processed data sources are already made
## available! (for further information, run:
## vignette("v020_datastorage", package = "n2khab"))
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #


# Generating the data folder inside this repository
# -------------------------------------------------

n2khab::filemanag_folders(root = "git")


# Generating GeoTIFF and GPKG files, derived from the GRTSmaster_habitats data source
# --------------------------------------------------------------------------

# Be warned: this can take > 10 hours.

setwd("src/generate_GRTS_10_GRTSmh_base4frac")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')

setwd("src/generate_GRTS_20_GRTSmh_brick")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')

setwd("src/generate_GRTS_30_GRTSmh_diffres")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')


# Generating habitatmap_stdized
# ------------------------------

setwd("src/generate_habitatmap_stdized")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')

# Generating watersurfaces_hab
# ------------------------------

setwd("src/generate_watersurfaces_hab")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')


# Generating habitatmap_terr
# ------------------------------

setwd("src/generate_habitatmap_terr")
rmarkdown::render_site(output_format = 'bookdown::html_document2',
                       encoding = 'UTF-8')








