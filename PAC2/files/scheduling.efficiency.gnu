set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400
set output OUT

set multiplot layout 1,2 title TITLE font ",14"
#
set title "lu"
set boxwidth 0.75   
set style fill solid
set xtics rotate by 90 right
set yrange [0:*]
set tics font ", 8"
unset key
plot "lu_scheduling.dat" using 5:xtic(1) with boxes
#
set title "sp"
set boxwidth 0.75
set style fill solid
set xtics rotate by 90 right
set yrange [0:*]
set tics font ", 8"
unset key
plot "sp_scheduling.dat" using 5:xtic(1) with boxes
#
unset multiplot
