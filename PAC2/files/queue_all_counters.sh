#!/bin/bash

for name in counters counters2 counters.v1 counters2.v1 counters.v2 counters2.v2
do
    ./queue_counters.sh -n ${name}
done
