set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 800
set output OUT

set multiplot layout 3,3 title TITLE font ",14"
set xtics rotate
set bmargin 3
#
# FT
#
set title "ft.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
unset key
plot "ft.".IN.".PTSE.dat" u 1:2 w lp lt 1
#
set title "ft.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
unset key
plot "ft.".IN.".PTSE.dat" using 1:3 w lp lt 2
#
set title "ft.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
plot "ft.".IN.".PTSE.dat" using 1:4 w lp lt 3
##
# LU
#
set title "lu.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
unset key
plot "lu.".IN.".PTSE.dat" u 1:2 w lp lt 1
#
set title "lu.".IN  
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
unset key
plot "lu.".IN.".PTSE.dat" using 1:3 w lp lt 2
#
set title "lu.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
plot "lu.".IN.".PTSE.dat" using 1:4 w lp lt 3
#
# SP
#
set title "sp.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Time (s)"
unset key
plot "sp.".IN.".PTSE.dat" u 1:2 w lp lt 1
#
set title "sp.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Speedup"
unset key
plot "sp.".IN.".PTSE.dat" using 1:3 w lp lt 2
#
set title "sp.".IN
set xtics 1
set yrange [0:*]
set xlabel "Number of threads (n)"
set ylabel "Efficiency"
plot "sp.".IN.".PTSE.dat" using 1:4 w lp lt 3
#
unset multiplot
