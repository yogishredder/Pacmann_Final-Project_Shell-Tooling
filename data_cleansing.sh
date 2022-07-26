#!/bin/bash

#1.Combined data
echo -e "1. Combine two CSV data into combined_file.csv"  
csvstack data/2019-Oct-sample.csv data/2019-Nov-sample.csv > data/combined_file.csv
echo -e "Successfully combined"
echo -e "Preview of combined file\n"
head data/combined_file.csv | csvlook

#2.Choose relevant column
echo -e "\n\n2. Select relevant column and store into relevant_data.csv"
csvcut -c 2,3,4,5,7,8,6 data/combined_file.csv > data/relevant_data.csv
echo -e "Successfully executed"
echo -e "Preview of relevant column"
head data/relevant_data.csv | csvlook

#3.Filter to purchase type
echo -e "\n\n3. Filter to purchase type"
csvgrep -c "event_type" -m purchase data/relevant_data.csv > data/purchase_relevant_data.csv
echo -e "Successfully executed"
echo -e "Preview of purchase type"
head data/purchase_relevant_data.csv | csvlook

#4.Split category_code column to category & product_name
echo -e "\n\n4. Split category_code column to category & product_name"
#create csv dummy file with header
echo "category,product_name" > data/dummy_split_data.csv
#split only category_code and overwrite the dummy 
csvcut -c "category_code" data/purchase_relevant_data.csv | tail +2 | awk -F "." 'OFS="," {print $1, $NF}' >> data/dummy_split_data.csv
echo -e "Succesfully split category_code column"
echo -e "Preview of category & product_name"
head data/dummy_split_data.csv | csvlook

#5.Join CSV for final preview
echo -e "\n\n5.Final data cleansing"
#join csv files & extract except category_code column
csvjoin data/purchase_relevant_data.csv data/dummy_split_data.csv | csvcut -C "category_code" > data/data_clean.csv
echo -e "Succesfully joined\nPreview data after cleansing"
head data/data_clean.csv | csvlook

#6.Validasi hasil
echo -e "\n\n6.Data Validation"
cat data/data_clean.csv | wc
cat data/data_clean.csv | grep electronics | grep smartphone| awk -F ',' '{print $5}'|
sort | uniq -c | sort -nr
echo -e "\n\nData Cleansing Completed"
