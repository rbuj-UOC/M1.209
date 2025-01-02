#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -n NAME

example: $0 -n mm_omp

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

for NUM in {2..4}
do
    for SAMPLE in {1..10}
    do
        echo qsub -N ${name}_${NUM}_${SAMPLE} -v name=${name} \
-v OMP_NUM_THREADS=${NUM} omp_time.sge
    done
done
echo qsub -hold_jid \"${name}_*\" -N ${name}_end -v name=${name} \
-cwd ./omp_time_end.sge
