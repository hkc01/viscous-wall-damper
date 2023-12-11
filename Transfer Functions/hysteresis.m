close all, clear, clc
T= readmatrix("fd.xlsx");
ix= 6:37;

F= T(ix, 2:5); d= T(ix, 1);

plot(d, F), grid
AoC= trapz(d, F*1e3)
b50= AoC(2)
