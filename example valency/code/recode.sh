#!/usr/bin/env bash

for file in *.txt ; do
     iconv -f UTF-16LE -t UTF-8 "$file" | tr -d "\r" > ../data_recoded/"$file"
done
