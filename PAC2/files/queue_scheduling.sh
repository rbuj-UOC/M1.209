#!/bin/bash

for SCHEDULING in static dynamic,1 dynamic,2 dynamic,4 dynamic,8 dynamic,16 dynamic,32 guided,1 guided,2 guided,4 guided,8 guided,16 guided,32
do
    SUFIX=${SCHEDULING/,/.}

    for KERNEL in sp lu
    do
        for SAMPLE in {1..10}
        do
      	    echo qsub -N ${KERNEL}_${SCHEDULING/,/_}_${SAMPLE} \
-v name=${KERNEL}.W.${SUFIX} \
-v OMP_NUM_THREADS=4 scheduling.sge
        done
    done
done
