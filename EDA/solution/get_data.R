# get_data.R
library(optparse)

option_list = list(
  make_option(c("-i","--input"),
               type="character",
               default="diabetes.csv",
               help="dataset file name",
               metavar="character"
              ),
  make_option(c("-o","--output"),
               type="character",
               default="data_raw.csv",
               help="output file name",
               metavar="character"
              )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
data_raw <- read.csv(paste0("data/",args[1]))
write.csv(data_raw, paste0("data/",args[2]),row.names=FALSE)