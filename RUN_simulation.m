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

%odabir
%1 ---> Adam
%2 ---> AdaGrad
%3 ---> RMSProp
%4 ---> RMSProm with Nester Momentum
odabir = 1;



digits(50)
kGravity = 9.80665;
mass_ = 1.0;
mass_quad_ = 30.8;
M_ = mass_quad_ + 4 * mass_;
mi_ = mass_ / mass_quad_;
cd_ = 1.5;
zr_ = 0.2;
beta_ = 0;
beta_gm_ = 0;
zm_ = 0.05;
Km_ = 1;

lm_ = 0.6;
arm_offset_ = 0.1;
l_ = lm_ + arm_offset_;
Tr_ = 100;
 Iq_xx = 5.5268 + 0.2;
 Iq_yy = 5.5268 + 0.2;
 Iq_zz = 6.8854 + 0.4;
Iq_ = zeros(3, 3);
Iq_(1, 1) = Iq_xx;
Iq_(2, 2) = Iq_yy;
Iq_(3, 3) = Iq_zz;
Iyy_b_ = 5.5268;
Iyy_ = Iyy_b_ + 2 * mass_ * (lm_ / 2)^ 2;

Tgm_ = 0.25;
w_gm_n_ = 7000 / 60 * 2 * pi;
F_n_ = 25 * kGravity;
b_gm_f_ = F_n_ / (w_gm_n_^ 2);
b_gm_m_ = 0.01;

w_gm_0_ = sqrt(M_ * kGravity / 4.0 / b_gm_f_);
F0_ = b_gm_f_ * w_gm_0_^ 2;





zeta_mm_ = 0.6544;
w_mm_ = 19.7845;
A_continous_time = zeros(8,8);
A_continous_time(1+0, 1+ 1) = 1.0;
A_continous_time(1+1, 1+ 0) = -(w_mm_^ 2);
A_continous_time(1+1, 1+ 1) = -2.0 * zeta_mm_ * w_mm_;
A_continous_time(1+2, 1+ 3) = 1.0;
A_continous_time(1+3, 1+ 2) = -(w_mm_^  2);
A_continous_time(1+3, 1+ 3) = -2.0 * zeta_mm_ * w_mm_;
A_continous_time(1+4, 1+ 4) = -1.0 / Tgm_;
A_continous_time(1+5, 1+ 5) = -1.0 / Tgm_;
A_continous_time(1+6, 1+ 7) = 1.0;
A_continous_time(1+7, 1+ 0) = 1.0 * mass_ / Iyy_ * (kGravity + ((1.0 - 4.0 * mi_) * zm_ * (w_mm_^ 2)));
A_continous_time(1+7, 1+ 1) = 2.0 * mass_ * (1.0 - 4.0 * mi_) * zm_ * zeta_mm_ * w_mm_ / Iyy_;
A_continous_time(1+7, 1+ 2) = mass_ / Iyy_ * (kGravity + ((1.0 - 4.0 * mi_) * zm_ * (w_mm_^ 2)));
A_continous_time(1+7, 1+ 3) = 2.0 * mass_ * (1.0 - 4.0 * mi_) * zm_ * zeta_mm_ * w_mm_ / Iyy_;
A_continous_time(1+7, 1+ 4) = 2 * b_gm_f_ * w_gm_0_ * lm_ / Iyy_;
A_continous_time(1+7, 1+ 5) = -2 * b_gm_f_ * w_gm_0_ * lm_ / Iyy_;

B_continous_time(1+1, 1+ 0) = (w_mm_^ 2);
B_continous_time(1+3, 1+ 1) = (w_mm_^ 2);
B_continous_time(1+4, 1+ 2) = 1.0 / Tgm_;
B_continous_time(1+5, 1+ 3) = 1.0 / Tgm_;
B_continous_time(1+7, 1+ 0) = -mass_ * (1.0 - 4.0 * mi_) * zm_ * w_mm_^ 2 / Iyy_;
B_continous_time(1+7, 1+ 1) = -mass_ * (1.0 - 4.0 * mi_) * zm_ * w_mm_^ 2 / Iyy_;




kSamplingTime = 0.04;
A_dis_calc = expm(kSamplingTime*A_continous_time);

count_integral_A = 100;
integral_exp_A = 0*A_dis_calc;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_dis_calc = integral_exp_A * B_continous_time;


A_dis_calc =[    0.4271,    0.0223,         0,         0,         0,         0,         0 ,        0;
   -8.7243,   -0.1501,         0,         0,         0,         0,         0,         0;
         0,         0,    0.4271,    0.0223,         0,         0,         0,         0;
         0,         0,   -8.7243,   -0.1501,         0,         0,         0,         0;
         0,         0,         0,         0,    0.7300,         0,         0,         0;
         0,         0,         0,         0,         0,    0.7300,         0,         0;
    0.0090,    0.0005,    0.0090,    0.0005,    0.0001,   -0.0001,    1.0000,    0.0787;
    0.1699,    0.0113,    0.1699,    0.0113,    0.0028,   -0.0028,         0 ,   1.0000];
    
B_dis_calc =[ 0.5729,         0 ,        0 ,        0;
    8.7243,         0   ,      0 ,        0;
         0,    0.5729  ,       0 ,        0;
         0,    8.7243 ,        0 ,        0;
         0,         0 ,   0.2700 ,        0;
         0,         0 ,        0 ,   0.2700;
   -0.0037,   -0.0037,    0.0000 ,  -0.0000;
   -0.0347,   -0.0347,    0.0005 ,  -0.0005];

%%
% syms s
% factor((19.7845*s)^2 + 2*19.7845*0.6544*s + 1, s, 'FactorMode', 'real')

sim MORUS_NELINEARNI_ALGH

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
