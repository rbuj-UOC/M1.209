#!/bin/bash

function usage () {
cat << EOF
usage:
  $0 -n NAME

example: $0 -n flops

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

for SAMPLE in {1..10}
do
    echo qsub -N ${name}_${SAMPLE} -v name=${name} \
papi.sge
done
echo qsub -hold_jid \"${name}_*\" -N ${name}_end \
-v name=${name} -cwd ./papi_end.sge

