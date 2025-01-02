#!/bin/bash

for CLASS in W A
do
    for KERNEL in ft sp lu
    do
        ./sumarize_npb_kernel.sh -k ${KERNEL} -c ${CLASS}
        gnuplot -e "IN='${KERNEL}.${CLASS}.dat'; OUT='${KERNEL}.${CLASS}.png'; TITLE='${KERNEL}.${CLASS}'" et.gnu
    done
    gnuplot -e "IN='${CLASS}'; OUT='${CLASS}.PTSE.png'; TITLE='Execution Time, Speedup and Efficiency: ${CLASS}'" big.ptse.gnu
done
gnuplot ptse.gnu
