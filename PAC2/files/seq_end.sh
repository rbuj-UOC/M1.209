#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -n NAME

EOF
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

FILE=${name}.csv
echo "size,sum_time,global_time,sum_result" > $FILE
for SAMPLE in {1..10}
do
    tail -n 1 -q ${name}_${SAMPLE}.*.out >> $FILE
done
