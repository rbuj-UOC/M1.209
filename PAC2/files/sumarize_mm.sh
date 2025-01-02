#!/bin/bash
for name in mm mm2
do
    ./sumarize_csv.sh -s ${name} -p ${name}_omp -c real -o ${name}.dat
     gnuplot -e "IN='${name}.dat'; OUT='${name}.png'; TITLE='Matrix multiplication using the for of omp'" et.gnu
done
