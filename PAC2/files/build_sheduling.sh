#!/bin/bash

BASE_DIR=$PWD
NPB_DIR=NPB3.2-OMP

cp -rp /share/apps/aca/benchmarks/NPB3.2/${NPB_DIR} .
cd ${NPB_DIR}
rm -fr bin/*

for KERNEL in sp lu
do
    make clean
    make ${KERNEL} CLASS=W
    mv bin/${KERNEL}.W ~/bin/${KERNEL}.W.static
done

OLD=static
for SCHEDULING in dynamic,1 dynamic,2 dynamic,4 dynamic,8 dynamic,16 dynamic,32 guided,1 guided,2 guided,4 guided,8 guided,16 guided,32
do
    FROM=$OLD
    TO=$SCHEDULING
    SUFIX=${TO/,/.}

    sed -i "s/schedule($FROM)/schedule($TO)/g" SP/*.f
    sed -i "s/schedule($FROM)/schedule($TO)/g" LU/*.f

    for KERNEL in sp lu
    do
        make clean
        make ${KERNEL} CLASS=W
        mv bin/${KERNEL}.W ~/bin/${KERNEL}.W.${SUFIX}
    done

    OLD=$SCHEDULING
done

cd ${BASE_DIR}
rm -fr ${NPB_DIR}
