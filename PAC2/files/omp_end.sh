#!/bin/bash

function usage () {
  echo USAGE: $0 -n NAME
}

while getopts n: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
    esac
done
if [ -z "${name}" ]; then
  usage
  exit
fi

for NUM in {2..4}
do
    FILE=${name}_${NUM}.csv
    echo "size,sum_time,global_time,sum_result" > $FILE
    for SAMPLE in {1..10}
    do
        tail -n 1 -q ${name}_${NUM}_${SAMPLE}.*.out >> $FILE
    done
done
