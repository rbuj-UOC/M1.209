#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -k NAME -c CLASS

example: $0 -k FT -c W

EOF
}

while getopts k:c: flag
do
    case "${flag}" in
        k) kernel=${OPTARG};;
        c) class=${OPTARG};;
    esac
done
if [ -z "${kernel}" ] || [ -z "${class}" ]; then
  usage
  exit
fi

for NUM in {1..4}
do
    for SAMPLE in {1..10}
    do
        echo qsub -N ${kernel}.${class}_${NUM}_${SAMPLE} \
-v kernel=${kernel} -v class=$class -v OMP_NUM_THREADS=${NUM} \
omp_npb.sge
    done
done
