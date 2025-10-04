#!/bin/bash


#####################
# Author: Taofeecoh
# Date: 08/09/2025
#
# This script is an ETL pipeline
#
# Version: v1
#####################

# Set variables
url="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
working_dir="/mnt/c/Users/adesa/OneDrive/Desktop/Data/DE/cde_bootcamp/linux_git"
timestamp=`date +\%Y-\%m-\%d,\%H:\%M:\%S`

# Extract
mkdir -p $working_dir/raw $working_dir/log
echo "$timestamp ::: extracting..." > $working_dir/log/script.log
/usr/bin/curl "$url" > "$working_dir/raw/enterprise-survey-2023.csv"

echo "$timestamp ::: confirming download success..." >> $working_dir/log/script.log
ls "$working_dir/raw" >> $working_dir/log/script.log 2>&1

# Transform
sed -i '1s/Variable_code/variable_code/' "$working_dir/raw/enterprise-survey-2023.csv"

echo "$timestamp ::: transforming column" >> $working_dir/log/script.log
mkdir -p "$working_dir/Transformed"

echo "$timestamp ::: slicing data" >> $working_dir/log/script.log
cut -d "," -f 1,5,6,9 "$working_dir/raw/enterprise-survey-2023.csv" > "$working_dir/Transformed/2023_year_finance.csv"
ls "$working_dir/Transformed" >> $working_dir/log/script.log 2>&1
