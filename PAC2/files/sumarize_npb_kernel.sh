#!/bin/bash

declare -a T
declare -a S
declare -a E

function usage () {
cat << EOF
usage:
  $0 -k NAME -c CLASS

example: $0 -k FT -c W

EOF
}

while getopts k:c: flag
do
    case "${flag}" in
        k) kernel=${OPTARG};;
        c) class=${OPTARG};;
    esac
done
if [ -z "${kernel}" ] || [ -z "${class}" ]; then
  usage
  exit
fi

output=${kernel}.${class}.dat
rm -f ${output}
for NUM in {1..4}
do
    FILE=${kernel}.${class}.${NUM}.csv
    rm -f ${FILE}
    for SAMPLE in {1..10}
    do
        # ft.A_4_5.1158379.err
        if [ ! -f ${kernel}.${class}_${NUM}_${SAMPLE}.*.out ]; then
            echo "Missing ${kernel}.${class}_${NUM}_${SAMPLE}.ID.out"
            continue
        fi
        OUT_FILE=`ls ${kernel}.${class}_${NUM}_${SAMPLE}.*.out`
        HOST=$(sed -n -r '/says/s/(.*) says/\1/p' ${OUT_FILE})
        TIME=$(sed -n -r '/Time in seconds/s/.* = \s+(.*)/\1/p' ${OUT_FILE})
        echo "${HOST},${TIME}" >> ${FILE}
    done
    sort -o $FILE $FILE
    sed -i '1i host,time' $FILE
    LINE=$(./sumarize_csv.py -f ${FILE} -n ${NUM} -c time)
    echo ${LINE} >> ${output}
    # split line, delimiter space
    arrLINE=(${LINE// / })
    T[$NUM]=${arrLINE[1]}
done

# compute $ and E
FILE=${kernel}.${class}.PTSE.dat
rm -f $FILE
for P in {1..4}
do
   S[${P}]=$(echo "scale=4;${T[1]}/${T[${P}]}" | bc)
   E[${P}]=$(echo "scale=4;${S[${P}]}/${P}" | bc)
   echo "${P} ${T[${P}]} ${S[${P}]} ${E[${P}]}" >> ${FILE}
done

# gnuplot
gnuplot -e "IN='${FILE}'; OUT='${kernel}.${class}.PTSE.png'; TITLE='${kernel}.${class}'" ptse.kernel.gnu 
