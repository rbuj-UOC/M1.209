# gnuplot -e "IN='lu_scheduling.dat'; OUT='lu_scheduling.png'; TITLE=test" scheduling.gnu
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400
set output OUT
set title TITLE 
set boxwidth 0.75   
set style fill solid
set xtics rotate by 90 right
set yrange [0:*]
set tics font ", 8"
unset key
plot IN using 5:xtic(1) with boxes
