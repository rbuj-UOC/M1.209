#!/bin/bash -x
rm -fr _minted report.{aux,log,synctex.gz,out} fit.log
mv report.pdf ../
make clean
