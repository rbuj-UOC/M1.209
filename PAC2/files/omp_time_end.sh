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
    echo "hostname,job_id,timestamp,real" > $FILE
    for SAMPLE in {1..10}
    do
        if [ ! -f ${name}_${NUM}_${SAMPLE}.*.out ]; then
            continue
        fi
        OUT_FILE=`ls ${name}_${NUM}_${SAMPLE}.*.out`
        ERR_FILE=`ls ${name}_${NUM}_${SAMPLE}.*.err`
        if grep 'Segmentation fault' $ERR_FILE;then
            continue
        fi
        JOB_ID="$(cut -d'.' -f2 <<<"$OUT_FILE")"
        HOST=`grep host ${OUT_FILE} | cut -d' ' -f2`
        TIME=`grep timestamp ${OUT_FILE} | cut -d' ' -f2`
        REAL=`grep real ${ERR_FILE} | cut -f2`
        REAL_TMP=(${REAL//m/ })
        REAL_MIN=${REAL_TMP[0]}
        REAL_TMP=(${REAL_TMP[1]//./ })
        REAL_SEC=${REAL_TMP[0]}
        REAL_TMP=(${REAL_TMP[1]//s/ })
        REAL_MIL=${REAL_TMP[0]}
        TOTAL=`echo "(${REAL_MIN} * 60) * 1000" | bc`
        TOTAL=`echo "${TOTAL} + (${REAL_SEC} * 1000)" | bc`
        TOTAL=`echo "${TOTAL} + ${REAL_MIL}" | bc`
        echo $HOST,$JOB_ID,$TIME,`echo "scale=3; ${TOTAL} / 1000" | bc` >> $FILE
    done
done
