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
# echo "host,Real_time,Proc_time,Total_flpins,MFLOPS" > $FILE
rm -f $FILE
for SAMPLE in {1..10}
do
    if [ ! -f ${name}_${SAMPLE}.*.out ]; then
        continue
    fi
    OUT_FILE=`ls ${name}_${SAMPLE}.*.out`
    ERR_FILE=`ls ${name}_${SAMPLE}.*.err`
    HOST=$(sed -n -r '/says/s/(.*) says/\1/p' ${OUT_FILE})
    REAL_TIME=$(sed -n -r '/MFLOPS/s/.*\:\t+(.*)/\1/p' ${OUT_FILE})
    PROC_TIME=$(sed -n -r '/Proc_time/s/.*\:\t+(.*)/\1/p' ${OUT_FILE})
    TOTAL_FLPINS=$(sed -n -r '/Total flpins/s/.*\:\t+(.*)/\1/p' ${OUT_FILE})
    MFLOPS=$(sed -n -r '/MFLOPS/s/.*\:\t+(.*)/\1/p' ${OUT_FILE})
    echo $HOST,$REAL_TIME,$PROC_TIME,$TOTAL_FLPINS,$MFLOPS >> $FILE
done
sort -o $FILE $FILE
gsed -i '1i host,Real_time,Proc_time,Total_flpins,MFLOPS' $FILE
