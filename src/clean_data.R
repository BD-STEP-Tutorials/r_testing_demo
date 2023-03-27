# clean_data.R
library(optparse)
suppressMessages(library(tidyverse))

option_list = list(
  make_option(c("-i","--input"),
              type="character",
              default="data_featured.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-o","--output"),
              type="character",
              default="data_clean.csv",
              help="output file name",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
data <- read.csv(paste0("data/",args[1]))

non_zero_vars <- c('Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI','DiabetesPedigreeFunction', 'Age')
data <- data %>% mutate_at(non_zero_vars, ~na_if(.,0))
write.csv(data, paste0("data/",args[2]),row.names=FALSE)
