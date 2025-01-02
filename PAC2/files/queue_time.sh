#!/bin/bash

# $0 -s mm -p mm_omp

function usage () {
cat << EOF
usage:
  $0 -s S_APP -p P_APP

example: $0 -s mm -p mm_omp

EOF
}

while getopts s:p: flag
do
    case "${flag}" in
        s) sequential=${OPTARG};;
        p) parallel=${OPTARG};;
    esac
done
if [ -z "${parallel}" ] || [ -z "${sequential}" ]; then
  usage
  exit
fi

./queue_sequential_time.sh -n ${sequential}
./queue_parallel_time.sh -n ${parallel}
