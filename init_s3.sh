#!/usr/bin/env bash

#
## list all buckets to create
#
#declare -a bucketNames=(
#  "bucket1"
#  "bucket2"
#  ...
#  "bucketN"
#)
#
#for bucketName in "${bucketNames[@]}"
#do
#    ./create_bucket.sh ${bucketName}
#done
#

#
## synchronize data from AWS S3 into s3local
#
#echo "sync bucket1 from production"
## download from AWS
#aws --region us-west-1 s3 cp s3://bucket1 /tmp/bucket1 --recursive
## upload into s3local
#aws --endpoint-url='http://localhost' s3 cp /tmp/bucket1 s3://bucket1 --recursive
#