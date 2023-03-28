.PHONY: all clean

.SILENT all: data/data_raw.csv data/data_featured.csv data/data_clean.csv \
data/train_raw.csv data/train.csv data/model.rds report/results.txt

data/data_raw.csv: src/get_data.R
	Rscript src/get_data.R -i diabetes.csv -o data_raw.csv 
	@echo "get_data.R Complete"

data/data_featured.csv: src/featurize_data.R
	Rscript src/featurize_data.R -i data_raw.csv -o data_featured.csv
	@echo "featurize_data.R Complete"
	
data/data_clean.csv: src/clean_data.R
	Rscript src/clean_data.R -i data_featured.csv -o data_clean.csv
	@echo "clean_data.R Complete"

data/train_raw.csv src/data/test_raw.csv: src/split_data.R
	Rscript src/split_data.R -i data_clean.csv -o train_raw.csv -O test_raw.csv
	@echo "split_data.R Complete"

data/train.csv src/data/test.csv: src/clean_split_data.R
	Rscript src/clean_split_data.R -i train_raw.csv -I test_raw.csv -o train.csv -O test.csv 
	@echo "clean_split_data.R Complete"

data/model.rds: src/train_model.R
	Rscript src/train_model.R -i train.csv -o model.rds 
	@echo "train_model.R Complete"

report/results.txt: src/evaluate_model.R
	Rscript src/evaluate_model.R -i test.csv -I model.rds
	@echo "evaluate_model Complete"

clean: 
	rm -r data/data_raw.csv
	rm -r data/data_featured.csv
	rm -r data/data_clean.csv
	rm -r data/train_raw.csv
	rm -r data/test_raw.csv
	rm -r data/train.csv
	rm -r data/test.csv
	rm -r data/model.rds