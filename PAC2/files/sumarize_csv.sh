#!/bin/bash

# ./sumarize_csv.sh -s sv_seq -p sv_omp -c sum_time -o sv.dat

function usage () {
cat << EOF
usage:
  $0 -s S_APP -p P_APP -c COLUMN -o OUTPUT

example: $0 -s sv -p sv_omp -c sum_time -o sv.dat

EOF
}

while getopts o:s:p:c: flag
do
    case "${flag}" in
        s) sequential=${OPTARG};;
        p) parallel=${OPTARG};;
        c) column=${OPTARG};;
        o) output=${OPTARG};;
    esac
done
if [ -z "${column}" ] || [ -z "${parallel}" ] || [ -z "${sequential}" ] || [ -z "${output}" ]; then
  usage
  exit 
fi

./sumarize_csv.py -f ${sequential}.csv -n 1 -c ${column} > ${output}
for NUM in {2..4}
do
    ./sumarize_csv.py -f ${parallel}_${NUM}.csv -n ${NUM} -c ${column} >> ${output}
done
