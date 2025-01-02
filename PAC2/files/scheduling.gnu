# gnuplot -e "IN='lu_scheduling.dat'; OUT='lu_scheduling.png'; TITLE=test" scheduling.gnu
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400
set output OUT

set multiplot layout 1,3 title TITLE font ",14"
set xtics rotate
set bmargin 5
set yrange [0:*]
#
set title "Time"
set boxwidth 0.75   
set style fill solid
set xtics rotate by 90 right
set tics font ", 10"
unset key
plot IN using 3:xtic(1) with boxes
#
set title "Speedup"
set boxwidth 0.75   
set style fill solid
set xtics rotate by 90 right
set tics font ", 10"
unset key
plot IN using 4:xtic(1) with boxes
#
set title "Efficiency"
set boxwidth 0.75   
set style fill solid
set xtics rotate by 90 right
set tics font ", 8"
unset key
plot IN using 5:xtic(1) with boxes
#
unset multiplot
