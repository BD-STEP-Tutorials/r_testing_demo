# split_data.R
library(optparse)
library(tidyverse)
set.seed(123)

option_list = list(
  make_option(c("-i","--input"),
              type="character",
              default="data_clean.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-o","--output1"),
              type="character",
              default="train_raw.csv",
              help="output file names",
              metavar="character"
  ),
  make_option(c("-O","--output2"),
              type="character",
              default="test_raw.csv",
              help="output file names",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
data <- read.csv(paste0("data/",args[1]))

nrows <- nrow(data)
index <- sample(1:nrows, 0.7 * nrows)

train <- data[index,]
test <- data[-index,]

write.csv(train, paste0("data/",args[2]),row.names=FALSE)
write.csv(test, paste0("data/",args[3]),row.names=FALSE)