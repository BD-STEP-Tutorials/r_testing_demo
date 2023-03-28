# train_model.R
suppressMessages(library(caret))
library(optparse)
set.seed(123)

option_list = list(
  make_option(c("-i","--input"),
              type="character",
              default="train.csv",
              help="dataset file name",
              metavar="character"
  ),
  make_option(c("-o","--output"),
              type="character",
              default="model.rds",
              help="output model file name",
              metavar="character"
  )
);

opt_parser = OptionParser(option_list=option_list)
args = parse_args(opt_parser)
train <- read.csv(paste0("data/",args[1]))

fitControl <- trainControl(method = ???,
                           number = ???, 
                           classProbs = ???,
                           summaryFunction = ???,
                           )

fit <- train(Diabetes~., 
              data=train, 
              method=???, 
              trControl = fitControl, 
              metric=???)

saveRDS(fit, file=paste0("data/",args[2]))
