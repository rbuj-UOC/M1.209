#!/bin/bash

function usage () {
  echo USAGE: $0 -f FILE
  echo $0 -f counters.v2.csv
}

while getopts f: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
    esac
done

if [ -z "${file}" ]; then
  usage
  exit
fi

for COL in l3_cache_misses flops instructions
do
  echo $COL = $(./mean_csv.py -f ${file} -c $COL)
done