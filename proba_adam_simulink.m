clc
clear all


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



% B_continous_time = [0        0        0        0;
%     391.426        0        0        0;
%     0        0        0        0;
%     0  391.426        0        0;
%     0        0        4        0;
%     0        0        0        4;
%     0        0        0        0;
%     -2.98409 -2.98409        0        0];
% 
% A_continous_time = [ 0          1          0          0          0          0          0          0;
%     -391.426    -25.894          0          0          0          0          0          0;
%     0          0          0          1          0          0          0          0;
%     0          0   -391.426    -25.894          0          0          0          0;
%     0          0          0          0         -4          0          0          0;
%     0          0          0          0          0         -4          0          0;
%     0          0          0          0          0          0          0          1;
%     4.7025   0.197406     4.7025   0.197406  0.0417255 -0.0417255          0          0];


A_dis =[    0.4271,    0.0223,         0,         0,         0,         0,         0 ,        0;
    -8.7243,   -0.1501,         0,         0,         0,         0,         0,         0;
    0,         0,    0.4271,    0.0223,         0,         0,         0,         0;
    0,         0,   -8.7243,   -0.1501,         0,         0,         0,         0;
    0,         0,         0,         0,    0.7300,         0,         0,         0;
    0,         0,         0,         0,         0,    0.7300,         0,         0;
    0.0090,    0.0005,    0.0090,    0.0005,    0.0001,   -0.0001,    1.0000,    0.0787;
    0.1699,    0.0113,    0.1699,    0.0113,    0.0028,   -0.0028,         0 ,   1.0000];

B_dis =[ 0.5729,         0 ,        0 ,        0;
    8.7243,         0   ,      0 ,        0;
    0,    0.5729  ,       0 ,        0;
    0,    8.7243 ,        0 ,        0;
    0,         0 ,   0.2700 ,        0;
    0,         0 ,        0 ,   0.2700;
    -0.0037,   -0.0037,    0.0000 ,  -0.0000;
    -0.0347,   -0.0347,    0.0005 ,  -0.0005];

% pomocni = A_continous_time(:,5);
% A_continous_time(:,5) = A_continous_time(:,6);
% A_continous_time(:,6) = pomocni;
% 
% pomocni = A_continous_time(5,:);
% A_continous_time(5,:) = A_continous_time(6,:);
% A_continous_time(6,:) = pomocni;
% 
% 
% pomocni = B_continous_time(:,3);
% B_continous_time(:,3) = B_continous_time(:,4);
% B_continous_time(:,4) = pomocni;
% 
% pomocni = B_continous_time(3,:);
% B_continous_time(3,:) = B_continous_time(4,:);
% B_continous_time(4,:) = pomocni;
% 
% 
% pomocni = A_dis(:,5);
% A_dis(:,5) = A_dis(:,6);
% A_dis(:,6) = pomocni;
% 
% 
% 
% pomocni = A_dis(5,:);
% A_dis(5,:) = A_dis(6,:);
% A_dis(6,:) = pomocni;
% 
% 
% pomocni = B_dis(:,3);
% B_dis(:,3) = B_dis(:,4);
% B_dis(:,4) = pomocni;
% 
% pomocni = B_dis(3,:);
% B_dis(3,:) = B_dis(4,:);
% B_dis(4,:) = pomocni;




kSamplingTime = 0.012;
A_dis_calc = expm(kSamplingTime*A_continous_time);

count_integral_A = 10000;
integral_exp_A = 0*A_dis_calc;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_dis_calc = integral_exp_A * B_continous_time;
scale_OV_inv = inv(diag([0.58, 4.0, 0.58, 4.0, 800, 800, 0.5236, 0.671578600000000]));
R =diag([0.67670, 0.67670, 0.13534000, 0.13534000]);
R_delta = diag([0.738879858135067, 0.738879858135067, 0.007388798581351,0.007388798581351]);
Q = diag([ 0.135340000000000,0.002706800000000,  0.1353400, 0.002706800, 0.002706800, 0.002706800,70.7068000, 9.676700]);

load theta.mat
t1 = 3.225806451612903


t2 =2.413976501908747


t3 = 3.225806451612903


t4 =   0


t5 = 3.225806451612903


t6 = 2.413976501908747


t7 = 3.225806451612903
% sim testiranje_bloka