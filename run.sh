#!/bin/bash

day=$1
year=$(date +"%Y")

ruby "src/${year}/${day}.rb" < "testdata/${year}/${day}.txt"
