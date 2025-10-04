#!/bin/bash

#################################
# Author: Taofeecoh
# Date: 18/09/2025
#
# Script to move csv and json files from one directory to another
#
#
#################################
#
#
workdir="/mnt/c/Users/adesa/OneDrive/Desktop/Data/DE/cde_bootcamp/linux_git"
mkdir -p "$workdir/json_and_CSV"

# Check if csv/json files exist
if compgen -G "$workdir/*csv" && compgen -G "$workdir/*json";
then
    mv $workdir/*.csv $workdir/*.json $workdir/json_and_CSV
    echo "json or csv files moved" >> $workdir/log/move_files.log
else
    echo "no matching files found" >> $workdir/log/move_files.log
fi
