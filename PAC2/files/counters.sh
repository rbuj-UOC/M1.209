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

FILE=${name}.csv
rm -f $FILE
for SAMPLE in {1..10}
do
    if [ ! -f ${name}_${SAMPLE}.*.out ]; then
        continue
    fi
    OUT_FILE=`ls ${name}_${SAMPLE}.*.out`
    ERR_FILE=`ls ${name}_${SAMPLE}.*.err`
    HOST=$(sed -n -r '/says/s/(.*) says/\1/p' ${OUT_FILE})
    FLOPS=$(sed -n -r '/Total hardware flops/s/.* = (.*)/\1/p' ${OUT_FILE})
    INSTRUCTIONS=$(sed -n -r '/Total instructions/s/.* (.*)/\1/p' ${OUT_FILE})
    echo $HOST,$FLOPS,$INSTRUCTIONS >> $FILE
done
if [ ! -f $FILE ]; then
  echo "ERROR: Empty file!"
  exit
fi
sort -o $FILE $FILE
#gsed -i '1i host,flops,instructions' $FILE
sed -i '1i host,flops,instructions' $FILE
