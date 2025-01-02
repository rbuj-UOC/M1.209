set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output OUT
set multiplot layout 1,2 title TITLE font ",14"
#
set title "sum time"
set style data lines
set xlabel "Number of threads (n)"
set xtics 1
set ylabel "Exection time (s)"
set yrange [0:*]
unset key
plot "sv_sum_time.dat" w errorbars title "Actual", "sv_sum_time.dat" u 1:2 w l lt 2
#
set title "global time"
set style data lines
set xlabel "Number of threads (n)" 
set xtics 1
set ylabel "Exection time (s)"
set yrange [0:*]
unset key
plot "sv_global_time.dat" w errorbars title "Actual", "sv_global_time.dat" u 1:2 w l lt 2
#
unset multiplot
