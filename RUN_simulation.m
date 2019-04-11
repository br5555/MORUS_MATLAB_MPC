clc
clear all
close all
clc
clear all
m = 1.0;
M = 34.8;
L = 0.6 %+0.1;
BETA = 0.0;
b_f = (25*9.81)/( (7000/(60*2*pi))^2 );
b_m = 0.01;
g = 9.81;
I_b_xx = 5.5268;
I_b_yy = 5.5268;
I_b_zz = 6.8854;
w_mm = 17;%19.7845;
zeta_mm = 0.85;%0.6544;
m_b = 30.8;
z_r = 0.2;
z_m = 0.05;
T_r = 0.25;
hover = 10.95359;




%%
syms s
factor((19.7845*s)^2 + 2*19.7845*0.6544*s + 1, s, 'FactorMode', 'real')

sim MORUS_NELINEARNI
