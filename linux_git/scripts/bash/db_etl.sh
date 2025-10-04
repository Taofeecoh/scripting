#!/bin/bash
#####################
# Author: Taofeecoh
# Date: 20/09/2025
#
#
#####################
#
# Variables
source .env

export PGPASSWORD="$DB_PASS"
timesatmp=`date +\%Y-\%m-\%d,\%H:\%M:\%S`
FILES="$workdir/database_files/*.csv"

for i in $FILES; do
    # Strip filename from directory path
    filename=$(basename "$i")
    table=${filename//.csv}

    header=$(head -n 1 "$i")
    columns=$(echo "$header" | sed 's/,/ VARCHAR(45),/g')
    columns="$columns VARCHAR(45)"

    echo "$timestamp ::: Now reading... $filename" >> $workdir/log/posey.log

    # Connect to database
    psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "
    DROP TABLE IF EXISTS "$table";
    CREATE TABLE IF NOT EXISTS $table ($columns);
    "
    \echo "$table created"
    psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "\copy $table FROM "$i" DELIMITER ','";
   
    echo "$timestamp ::: $filename loaded into $table table of database $DB_NAME" >> $workdir/log/posey.log
done

