#!/usr/bin/env bash

aws --endpoint-url='http://localhost' s3api create-bucket --bucket $@
