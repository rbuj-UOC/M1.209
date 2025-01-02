#!/bin/bash

for name in counters counters2
do
    ./counters.sh -n ${name}
done

for VERSION in {1..2}
do
    for name in counters counters2
    do
        ./counters.v${VERSION}.sh -n ${name}.v${VERSION}
        ./mean_counters_v${VERSION}.sh -f ${name}.v${VERSION}.csv > ${name}.v${VERSION}.txt
    done
done

