syms  w_mm zeta_mm  s
p = [1/(w_mm^2) 2*zeta_mm/(w_mm) 1]
r = roots(p)

provjera=simplify((s -( w_mm*((zeta_mm - 1)*(zeta_mm + 1))^(1/2) - w_mm*zeta_mm))*(s -(- w_mm*((zeta_mm - 1)*(zeta_mm + 1))^(1/2) - w_mm*zeta_mm)))
simplify(w_mm*((zeta_mm - 1)*(zeta_mm + 1))^(1/2) - w_mm*zeta_mm)
simplify(-w_mm*((zeta_mm - 1)*(zeta_mm + 1))^(1/2) - w_mm*zeta_mm)

%%
clc
clear all
w_mm = 10.8;
zeta_mm = 11.4;
x1 = -w_mm*(zeta_mm - (zeta_mm^2 - 1)^(1/2));
x2 = -w_mm*(zeta_mm + (zeta_mm^2 - 1)^(1/2));