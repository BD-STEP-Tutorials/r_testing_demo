# featurize_data.R
library(optparse)
suppressMessages(library(tidyverse))

option_list = list(
  make_option(c("-i","--input"),
              type="character",
              default="data_raw.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-o","--output"),
              type="character",
              default="data_featured.csv",
              help="output file name",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)

data <- as_tibble(read_csv(paste0("data/",args[1]), col_types=cols()))
data <- data %>% rename("Diabetes" = "Outcome") # changing name to Diabetes
data$Diabetes <- factor(data$Diabetes, levels=c(0,1), labels=c("No","Yes")) # making the outcome variable a factor as well as changing binary 0/1 to No/Yes for readibility
write.csv(data, paste0("data/",args[2]),row.names=FALSE)
