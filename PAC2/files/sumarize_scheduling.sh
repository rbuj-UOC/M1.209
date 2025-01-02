#!/bin/bash
declare -i p
p=4

for KERNEL in sp lu
do
    outputCSV=${KERNEL}_scheduling.csv
    outputDAT=${KERNEL}_scheduling.dat
    echo "scheduling,num_threads,run_time,speedup,efficiency" > ${outputCSV}

    LINE=$(./sumarize_csv.py -f ${KERNEL}.W.1.csv -n 1 -c time)
    # split line, delimiter space
    arrLINE=(${LINE// / })
    seqTIME=${arrLINE[1]}
    echo "static,1,${seqTIME},1,1" >> ${outputCSV}
    echo "static 1 ${seqTIME} 1 1" > ${outputDAT}

    for SCHEDULING in static dynamic,1 dynamic,2 dynamic,4 dynamic,8 dynamic,16 dynamic,32 guided,1 guided,2 guided,4 guided,8 guided,16 guided,32
    do
        ./sumarize_scheduling_kernel.sh -k ${KERNEL} -s ${SCHEDULING/,/_}

        inFILE=${KERNEL}_${SCHEDULING/,/_}.csv
        if [ ! -f $inFILE ]; then
            continue
        fi
        LINE=$(./sumarize_csv.py -f ${inFILE} -n ${p} -c time)
        # split line, delimiter space
        arrLINE=(${LINE// / })
        parTIME=${arrLINE[1]}

        s=$(echo "scale=4;${seqTIME}/${parTIME}" | bc)
        e=$(echo "scale=4;${s}/${p}" | bc)

        if [ $SCHEDULING = "static" ]; then
            scheduling="static-4t"
        else
            scheduling=${SCHEDULING/,/-}
        fi
        echo "${SCHEDULING/,/_},${p},${parTIME},${s},${e}" >> ${outputCSV}
        echo "${scheduling} ${p} ${parTIME} ${s} ${e}" >> ${outputDAT}
    done

    gnuplot -e "IN='${KERNEL}_scheduling.dat'; OUT='${KERNEL}_scheduling.png'; TITLE='Scheduling ${KERNEL}'" scheduling.gnu
    gnuplot -e "IN='${KERNEL}_scheduling.dat'; OUT='${KERNEL}_scheduling_e.png'; TITLE='Efficiency ${KERNEL}'" scheduling.efficiency.kernel.gnu
    gnuplot -e "IN='${KERNEL}_scheduling.dat'; OUT='${KERNEL}_scheduling_t.png'; TITLE='Execution Time ${KERNEL}'" scheduling.runtime.kernel.gnu
    gnuplot -e "IN='${KERNEL}_scheduling.dat'; OUT='${KERNEL}_scheduling_s.png'; TITLE='Speedup ${KERNEL}'" scheduling.speedup.kernel.gnu
done
gnuplot -e "OUT='scheduling_e.png'; TITLE='Efficiency lu and sp'" scheduling.efficiency.gnu
gnuplot -e "OUT='scheduling_t.png'; TITLE='Execution Time lu and sp'" scheduling.runtime.gnu
gnuplot -e "OUT='scheduling_s.png'; TITLE='Speedup lu and sp'" scheduling.speedup.gnu
