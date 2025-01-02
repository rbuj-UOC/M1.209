# https://www.youtube.com/watch?v=9QUtcfyBFhE
# https://ctcms-uq.github.io/data_tutorials/gnuplot.html Curve fitting
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output outputname
set title "Performance estimation"
set style data lines
set xlabel "Square matrix dimension (n)" 
set ylabel "Exection time (s)"
f(x) = c + b*x + a*x*x + d*x*x*x +e*x*x*x*x
fit f(x) datafile via a,b,c,d,e
plot [1:1600][0:] datafile w errorbars title "Actual", f(x) title "Model"
