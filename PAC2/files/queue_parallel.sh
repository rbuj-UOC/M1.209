#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -n NAME -s NUMBER

example: $0 -n sv_omp -s 1000

EOF
}

while getopts n:s: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
        s) size=${OPTARG};;
    esac
done
if [ -z "${name}" ] || [ -z "${size}" ]; then
  usage
  exit
fi

for NUM in {2..4}
do
    for SAMPLE in {1..10}
    do
        echo qsub -N ${name}_${NUM}_${SAMPLE} -v name=${name} \
-v size=${size} -v OMP_NUM_THREADS=${NUM} omp.sge
    done
done
echo qsub -hold_jid \"${name}_*\" -N ${name}_end -v name=${name} \
-cwd ./omp_end.sge
