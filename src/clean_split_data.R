# clean_split_data.R
library(optparse)
suppressMessages(library(tidyverse))
suppressMessages(library(caret))

option_list = list(
  make_option(c("-i","--input1"),
              type="character",
              default="train_raw.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-I","--input2"),
              type="character",
              default="test_raw.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-o","--output1"),
              type="character",
              default="train.csv",
              help="output training file name",
              metavar="character"
  ),
  make_option(c("-O","--output2"),
              type="character",
              default="test.csv",
              help="output test file name",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
train_raw <- read.csv(paste0("data/",args[1]))
test_raw <- read.csv(paste0("data/",args[2]))

train <- train_raw %>% drop_na()
test <- test_raw %>% drop_na()

write.csv(train, paste0("data/",args[3]),row.names=FALSE)
write.csv(test, paste0("data/",args[4]),row.names=FALSE)
