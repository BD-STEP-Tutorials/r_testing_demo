# evaluate_model.R
suppressMessages(library(caret))
library(optparse)

option_list = list(
  make_option(c("-i","--input1"),
              type="character",
              default="test.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-I","--input2"),
              type="character",
              default="model.rds",
              help="model/fit file name",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
test <- read.csv(paste0("data/",args[1]))
fit <- readRDS(paste0("data/",args[2]))

predict <- predict(fit, test[,-nrow(test)])
cm <- confusionMatrix(predict, as.factor(test$Diabetes))
capture.output(cm, file="results.txt")