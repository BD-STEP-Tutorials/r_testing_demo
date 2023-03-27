all: EDA/solution/data/data_raw.csv EDA/solution/data/data_featured.csv EDA/solution/data/data_clean.csv \
EDA/solution/data/train_raw.csv EDA/solution/data/test_raw.csv EDA/solution/data/train.csv  EDA/solution/data/test.csv \
EDA/solution/data/model.rds EDA/solution/data/results.txt

EDA/solution/data/data_raw.csv: EDA/solution/get_data.R
	R --args -i diabetes.csv -o data_raw.csv < EDA/solution/get_data.R

EDA/solution/data/data_featured.csv: EDA/solution/featurize_data.R
	R --args -i data_raw.csv -o data_featured.csv < EDA/solution/featurize_data.R
	
EDA/solution/data/data_clean.csv: EDA/solution/clean_data.R
	R --args -i data_featured.csv -o data_clean.csv < EDA/solution/clean_data.R

EDA/solution/data/train_raw.csv EDA/solution/data/test_raw.csv: EDA/solution/split_data.R
	R --args -i data_clean.csv -o train_raw.csv -O test_raw.csv < EDA/solution/split_data.R

EDA/solution/data/train.csv EDA/solution/data/test.csv: EDA/solution/clean_split_data.R
	R --args -i train_raw.csv -I test_raw.csv -o train.csv -O test.csv < EDA/solution/clean_split_data.R

EDA/solution/data/model.rds: EDA/solution/train_model.R
	R --args -i train.csv -o model.rds < EDA/solution/train_model.R

EDA/solution/data/results.txt: EDA/solution/evaluate_model.R
	R --args -i test.csv -I model.rds < EDA/solution/evaluate_model.R