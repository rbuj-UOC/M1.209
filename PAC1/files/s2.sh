#!/bin/bash
while getopts n: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
    esac
done
for NUM in 10 50 100 500 1000 1500
do
    for SAMPLE in {1..10}
    do
        echo qsub -N ${name}_${NUM}_${SAMPLE} -v name=${name} \
-v size=${NUM} template.sge
    done
done
echo qsub -hold_jid \""${name}_*"\" -N "${name}_end" \
-v name=${name} -cwd ./s3.sge
