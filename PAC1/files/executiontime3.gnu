# https://www.youtube.com/watch?v=9QUtcfyBFhE
# https://ctcms-uq.github.io/data_tutorials/gnuplot.html Curve fitting
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output 'q2-loop.png'
set title "Performance estimation gcc -O3"
set style data lines
set xlabel "Square matrix dimension (n)" 
set ylabel "Exection time (s)"
f(x) = c + b*x + a*x*x + d*x*x*x
fit f(x) 'loppO3.dat' via a,b,c,d
g(x) = j + k*x + l*x*x + m*x*x*x
fit g(x) 'app.dat' via j,k,l,m
plot [1:1600][0:] 'loppO3.dat' w errorbars title "Actual loop reordering", f(x) title "Model loop reordering", 'app.dat' w errorbars title "Actual regular", g(x) title "Model regular"
