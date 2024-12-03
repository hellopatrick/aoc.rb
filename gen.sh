#!/bin/bash

day=$1
year=$(date +"%Y")

echo "generate files: src/${year}/${day}.rb"

mkdir -p "src/${year}"
mkdir -p "testdata/${year}"

cat <<EOF > "src/${year}/${day}.rb"
# frozen_string_literal: true

_lines = ARGF.readlines
EOF

touch "testdata/${year}/${day}.txt"
