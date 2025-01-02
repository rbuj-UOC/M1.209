#!/bin/bash
for COL in sum_time global_time
do
    ./sumarize_csv.sh -s sv -p sv_omp -c ${COL} -o sv_${COL}.dat
    gnuplot -e "IN='sv_${COL}.dat'; OUT='sv_${COL}.png'; TITLE='Getting the sum of a vector using the reduction of omp'" et.gnu
done
gnuplot -e "OUT='sv.png'; TITLE='Getting the sum of a vector using the reduction of omp'" et.all.gnu
