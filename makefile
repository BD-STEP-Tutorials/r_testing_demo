.SILENT all: EDA/solution/data/data_raw.csv EDA/solution/data/data_featured.csv EDA/solution/data/data_clean.csv \
EDA/solution/data/train_raw.csv EDA/solution/data/train.csv EDA/solution/data/model.rds EDA/solution/data/results.txt

EDA/solution/data/data_raw.csv: EDA/solution/get_data.R
	Rscript EDA/solution/get_data.R -i diabetes.csv -o data_raw.csv 
	@echo "get_data.R Complete"

EDA/solution/data/data_featured.csv: EDA/solution/featurize_data.R
	Rscript EDA/solution/featurize_data.R -i data_raw.csv -o data_featured.csv
	@echo "featurize_data.R Complete"
	
EDA/solution/data/data_clean.csv: EDA/solution/clean_data.R
	Rscript EDA/solution/clean_data.R -i data_featured.csv -o data_clean.csv
	@echo "clean_data.R Complete"

EDA/solution/data/train_raw.csv EDA/solution/data/test_raw.csv: EDA/solution/split_data.R
	Rscript EDA/solution/split_data.R -i data_clean.csv -o train_raw.csv -O test_raw.csv
	@echo "split_data.R Complete"

EDA/solution/data/train.csv EDA/solution/data/test.csv: EDA/solution/clean_split_data.R
	Rscript EDA/solution/clean_split_data.R -i train_raw.csv -I test_raw.csv -o train.csv -O test.csv 
	@echo "clean_split_data.R Complete"

EDA/solution/data/model.rds: EDA/solution/train_model.R
	Rscript EDA/solution/train_model.R -i train.csv -o model.rds 
	@echo "train_model.R Complete"

EDA/solution/data/results.txt: EDA/solution/evaluate_model.R
	Rscript EDA/solution/evaluate_model.R -i test.csv -I model.rds
	@echo "evaluate_model Complete"