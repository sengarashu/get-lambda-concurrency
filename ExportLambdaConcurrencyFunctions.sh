#!/usr/bin/env bash
# Stetting Up Environment Variables
region=us-east-2
profile=prod
filename=prod-ohio-lambda-config.json
# Main Script
mkdir $folder
aws lambda list-functions --region $region --profile $profile | \
grep FunctionName | \
cut -d '"' -f4 | \
while read -r name; do
    awsfunction=$(aws lambda get-function-concurrency --function-name $name --region $region --profile $profile)
    STRLENGTH=$(echo -n $awsfunction | wc -m)
    echo $STRLENGTH
    if [ $STRLENGTH != 3 ]
    then
    echo "FunctionName": $name | tee -a $filename
    echo $awsfunction | tee -a $filename
    else
    echo $name
    fi
done
