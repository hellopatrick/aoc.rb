#!/bin/bash

day=$1
year=$(date +"%Y")

echo "running day${day}"
ruby "src/${year}/${day}.rb" < "testdata/${year}/${day}.txt"
