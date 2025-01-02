set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 800
set output "ptse.png"

set multiplot layout 3,3 title "Execution Time, Speedup and Efficiency: A vs W" font ",14"
set xtics rotate
set bmargin 3
#
# FT
#
set title "ft"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
set key right top
plot "ft.A.PTSE.dat" u 1:2 w lp lt 1 t "A", "ft.W.PTSE.dat" u 1:2 w lp lt 2 t "W"
#
set title "ft"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
set key right bottom
plot "ft.A.PTSE.dat" u 1:3 w lp lt 1 t "A", "ft.W.PTSE.dat" u 1:3 w lp lt 2 t "W
#
set title "ft"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
set key right bottom
plot "ft.A.PTSE.dat" u 1:4 w lp lt 1 t "A", "ft.W.PTSE.dat" u 1:4 w lp lt 2 t "W"
#
# LU
#
set title "lu"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
set key right top
plot "lu.A.PTSE.dat" u 1:2 w lp lt 1 t "A", "lu.W.PTSE.dat" u 1:2 w lp lt 2 t "W"
#
set title "lu"  
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
set key right bottom
plot "lu.A.PTSE.dat" u 1:3 w lp lt 1 t "A", "lu.W.PTSE.dat" u 1:3 w lp lt 2 t "W"
#
set title "lu"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
set key right bottom
plot "lu.A.PTSE.dat" u 1:4 w lp lt 1 t "A", "lu.W.PTSE.dat" u 1:4 w lp lt 2 t "W"
#
# SP
#
set title "sp"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
set key right top
plot "sp.A.PTSE.dat" u 1:2 w lp lt 1 t "A", "sp.W.PTSE.dat" u 1:2 w lp lt 2 t "W"
#
set title "sp"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
set key right bottom
plot "sp.A.PTSE.dat" u 1:3 w lp lt 1 t "A", "sp.W.PTSE.dat" u 1:3 w lp lt 2 t "W"
#
set title "sp"
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
set key right bottom
plot "sp.A.PTSE.dat" u 1:4 w lp lt 1 t "A", "sp.W.PTSE.dat" u 1:4 w lp lt 2 t "W"
#
unset multiplot
