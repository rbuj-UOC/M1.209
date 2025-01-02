#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -k KERNEL -s SCHEDULING

examples:

  $0 -k lu -s static
  $0 -k lu -s dynamic_1

EOF
}

while getopts k:s: flag
do
    case "${flag}" in
        k) kernel=${OPTARG};;
        s) scheduling=${OPTARG};;
    esac
done
if [ -z "${kernel}" ] || [ -z "${scheduling}" ]; then
  usage
  exit
fi

FILE=${kernel}_${scheduling}.csv
rm -f ${FILE}
for SAMPLE in {1..10}
do
    # lu_static_1.1161379.out
    if [ ! -f ${kernel}_${scheduling}_${SAMPLE}.*.out ]; then
        echo "Missing ${kernel}_${scheduling}_${SAMPLE}.ID.out"
        continue
    fi
    OUT_FILE=`ls ${kernel}_${scheduling}_${SAMPLE}.*.out`
    HOST=$(sed -n -r '/says/s/(.*) says/\1/p' ${OUT_FILE})
    TIME=$(sed -n -r '/Time in seconds/s/.* = \s+(.*)/\1/p' ${OUT_FILE})
    echo "${HOST},${TIME}" >> ${FILE}
done
sort -o $FILE $FILE
sed -i '1i host,time' $FILE
