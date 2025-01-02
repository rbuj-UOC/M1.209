#!/bin/bash
for name in mm mm2
do
    ./queue_time.sh -s ${name} -p ${name}_omp
done
