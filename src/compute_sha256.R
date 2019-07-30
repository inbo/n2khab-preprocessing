library(openssl)
library(tidyverse)

mypath <- "data"

hashes <-
    tibble(filepath = str_c(mypath, "/",
        list.files(path = mypath,
            recursive = TRUE)
      )) %>%
    mutate(filename = str_match(filepath, "(.+\\/)*(.+)")[,3],
           md5 = map(filepath, function(x) {
                           file(x) %>% md5 %>% str_c(collapse = '')
                         }) %>% as.character,
           sha256 = map(filepath, function(x) {
                          file(x) %>% sha256 %>% str_c(collapse = '')
                          }) %>% as.character
           ) %>%
    select(filepath,
           filename,
           md5,
           sha256)

hashes %>%
    write_csv("hashes.csv")
