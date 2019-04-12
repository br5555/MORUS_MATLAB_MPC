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
% syms s
% factor((19.7845*s)^2 + 2*19.7845*0.6544*s + 1, s, 'FactorMode', 'real')

sim MORUS_NELINEARNI_COMPLETE

figure();
plot(ROLL.time, ROLL.signals.values, 'LineWidth', 3); title('ROLL');

figure();
plot(PITCH.time, PITCH.signals.values, 'LineWidth', 3); title('PITCH');

figure();
plot(YAW.time, YAW.signals.values, 'LineWidth', 3); title('YAW');

figure();
plot(X.time, X.signals.values, 'LineWidth', 3); title('X axis');
hold on;
plot(DOT_X.time, DOT_X.signals.values, 'LineWidth', 3); 
hold on;
plot(DOT_DOT_X.time, DOT_DOT_X.signals.values, 'LineWidth', 3);  legend('X', 'DOT X', 'DOT DOT X');

figure();
plot(Y.time, Y.signals.values, 'LineWidth', 3); title('Y axis');
hold on;
plot(DOT_Y.time, DOT_Y.signals.values, 'LineWidth', 3); 
hold on;
plot(DOT_DOT_Y.time, DOT_DOT_Y.signals.values, 'LineWidth', 3); legend('Y', 'DOT Y', 'DOT DOT Y');

figure();
plot(Z.time, Z.signals.values, 'LineWidth', 3); title('Z axis');
hold on;
plot(DOT_Z.time, DOT_Z.signals.values, 'LineWidth', 3); 
hold on;
plot(DOT_DOT_Z.time, DOT_DOT_Z.signals.values, 'LineWidth', 3); legend('Z', 'DOT Z', 'DOT DOT Z');


figure();
plot(masa_x_1.time, masa_x_1.signals.values, 'LineWidth', 3); title('mass_1');

figure();
plot(masa_x_3.time, masa_x_3.signals.values, 'LineWidth', 3); title('mass_3');

figure();
plot(masa_y_2.time, masa_y_2.signals.values, 'LineWidth', 3); title('mass_2');

figure();
plot(masa_y_4.time, masa_y_4.signals.values, 'LineWidth', 3); title('mass_4');

figure();
plot(DOT_masa_x_1.time, DOT_masa_x_1.signals.values, 'LineWidth', 3); title('DOT mass_1');

figure();
plot(DOT_masa_x_3.time, DOT_masa_x_3.signals.values, 'LineWidth', 3); title('DOT mass_3');

figure();
plot(DOT_masa_y_2.time, DOT_masa_y_2.signals.values, 'LineWidth', 3); title('DOT mass_2');

figure();
plot(DOT_masa_y_4.time, DOT_masa_y_4.signals.values, 'LineWidth', 3); title('DOT mass_4');

figure();
plot(ROTOR_1.time, ROTOR_1.signals.values, 'LineWidth', 3); title('ROTOR_1');

figure();
plot(ROTOR_2.time, ROTOR_2.signals.values, 'LineWidth', 3); title('ROTOR_2');

figure();
plot(ROTOR_3.time, ROTOR_3.signals.values, 'LineWidth', 3); title('ROTOR_3');

figure();
plot(ROTOR_4.time, ROTOR_4.signals.values, 'LineWidth', 3); title('ROTOR_4');
