# https://www.youtube.com/watch?v=9QUtcfyBFhE
# https://ctcms-uq.github.io/data_tutorials/gnuplot.html Curve fitting
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output OUT
set title TITLE
set style data lines
set xlabel "Number of threads (n)" 
set xtics 1
set ylabel "Exection time (s)"
set yrange [0:*]
f(x) = a*x*x*x + b*x*x + c*x + d
fit f(x) IN via a,b,c,d
plot IN w errorbars title "Actual", f(x) title "Model"
