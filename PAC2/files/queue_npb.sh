#!/bin/bash

for KERNEL in ft sp lu
do
    for CLASS in W A
    do
        ./queue_npb_kernel.sh -k ${KERNEL} -c ${CLASS}
    done
done
