set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output OUT

set multiplot layout 1,3 title TITLE font ",14"
set xtics rotate
set bmargin 5
#
set title "Time"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
unset key
plot IN u 1:2 w lp lt 1
#
set title "Speedup"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
unset key
plot IN using 1:3 w lp lt 2
#
set title "Efficiency"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
plot IN using 1:4 w lp lt 3
#
unset multiplot
