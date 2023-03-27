all: data/data_raw.csv

data_raw.csv: get_data.R
	R --vanilla --args "" < "get_data.R"
