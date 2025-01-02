# https://www.youtube.com/watch?v=9QUtcfyBFhE
# https://ctcms-uq.github.io/data_tutorials/gnuplot.html Curve fitting
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output 'q2.png'
set title "Performance estimation"
set style data lines
set xlabel "Square matrix dimension (n)" 
set ylabel "Exection time (s)"
f(x) = c + b*x + a*x*x + d*x*x*x + e*x*x*x*x
fit f(x) 'app.dat' via a,b,c,d,e
g(x) = j + k*x + l*x*x + m*x*x*x + n*x*x*x*x
fit g(x) 'app2.dat' via j,k,l,m,n
plot [1:1600][0:] 'app.dat' w errorbars title "Actual gcc -O3", f(x) title "Model gcc -O3", 'app2.dat' w errorbars title "Actual gcc", g(x) title "Model gcc"
