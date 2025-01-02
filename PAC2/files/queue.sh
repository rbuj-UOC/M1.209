#!/bin/bash
# ./queue.sh -s sv -p sv_omp -n 1000

function usage () {
cat << EOF
usage:
  $0 -s S_APP -p P_APP -n NUMBER_ELEM

example: $0 -s sv -p sv_omp -n 1000

EOF
}

while getopts n:s:p: flag
do
    case "${flag}" in
        n) number=${OPTARG};;
        s) sequential=${OPTARG};;
        p) parallel=${OPTARG};;
    esac
done

if [ -z "${number}" ] || [ -z "${parallel}" ] || [ -z "${sequential}" ]; then
  usage
  exit
fi

./queue_sequential.sh -n ${sequential} -s ${number}
./queue_parallel.sh -n ${parallel} -s ${number}
