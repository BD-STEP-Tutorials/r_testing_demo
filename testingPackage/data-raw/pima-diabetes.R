## code to prepare `pima-diabetes` dataset goes here

library(tidyverse)
library(readr)

pima <- read_csv('data-raw/pima-indians-diabetes-2.csv')

usethis::use_data(pima, overwrite = TRUE)