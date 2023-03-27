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

fitControl <- trainControl(method = "cv", # k-fold Cross Validation (repeatedcv), bootstrap (boot) default, correlation (corr)
                           number = 10, # default is random 10 - 25
                           classProbs = TRUE, # default is FALSE
                           summaryFunction = twoClassSummary, # default is defaultSummary
                           )

fit <- train(Diabetes~., data=train, method='rpart', trControl = fitControl, metric="Spec")

saveRDS(fit, file=paste0("data/",args[2]))
