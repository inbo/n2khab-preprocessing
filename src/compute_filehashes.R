library(tidyverse)
library(n2khab)

mypath <- fileman_up("n2khab_data")

hashes <-
  tibble(filepath = str_c(mypath, "/",
                          list.files(path = mypath,
                                     recursive = TRUE)
  )) %>%
  mutate(
    filename = basename(filepath),
    xxh64 = xxh64sum(filepath),
    md5 = md5sum(filepath),
    sha256 = sha256sum(filepath)
  )

hashes %>%
  write_csv("hashes.csv")
