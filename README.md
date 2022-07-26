
# Data Cleansing in Shell

The project were aimed to complete continuation BI & DS non-degree program by Pacmann Data School


## Learning Objective

The objective of the tasks consisted of point below:
- Bash Scripting for data processing
- Applying csvkit for data processing
- Data cleansing in Shell
- Utilizing Git Version Control as repository

## Dataset

The dataset consists of data of e-commerce traffic that occured within October and November in 2019.   

## Task 
Before running data_cleansing.sh, make sure csvkit had already been installed in WSL and datasets were stored in folder 'data'
The file consists of following tasks:

1 Combine two files data 
```bash
  csvstack data/2019-Oct-sample.csv data/2019-Nov-sample.csv > data/combined_file.csv
```

2 Choose relevant columns that will be used for cleansing
```bash
csvcut -c 2,3,4,5,7,8,6 data/combined_file.csv > data/relevant_data.csv
```

3 Filter the row for purchase type
```bash
csvgrep -c "event_type" -m purchase data/relevant_data.csv > data/purchase_relevant_data.csv
```

4 Split category column into multiple column
```bash
echo "category,product_name" > data/dummy_split_data.csv
csvcut -c "category_code" data/purchase_relevant_data.csv | tail +2 | awk -F "." 'OFS="," {print $1, $NF}' >> data/dummy_split_data.csv
```

5 Join csv files for final preview  into 'data/purchase_relevant_data.csv'
```bash
csvjoin data/purchase_relevant_data.csv data/dummy_split_data.csv | csvcut -C "category_code" > data/data_clean.csv
```

6 Validation 
```bash
cat data/data_clean.csv | wc
cat data/data_clean.csv | grep electronics | grep smartphone| awk -F ',' '{print $5}'|
sort | uniq -c | sort -nr
```
## Authors

- [@Prayogi Adista](https://www.linkedin.com/in/prayogi-adista-purwanto-89878476/)

## Optimizations

What optimizations did you make in your code? E.g. refactors, performance improvements, accessibility

