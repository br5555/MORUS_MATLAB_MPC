% 
% close all
clc
clear all
m = 1.0;
M = 34;%34.8;
L =  0.84;%0.6 %+0.1;
BETA = 11.5 *(pi/180);
b_f = 4.56e-4;%(25*9.81)/( (7000/(60*2*pi))^2 );
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
T_r = 0.2;%0.25;
hover = 427.6233;

%odabir
%1 ---> Adam
%2 ---> AdaGrad
%3 ---> RMSProp
%4 ---> RMSProm with Nester Momentum
odabir = 1;



kGravity = 9.80665;
mass_ = 1.0;
mass_quad_ = 30.8;
M_ = mass_quad_ + 4 * mass_;
mi_ = mass_ / mass_quad_;
mi_ = mass_ / M_;
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
A_continous_time = zeros(10,10);
A_continous_time(1+0, 1+ 1) = 1.0;
A_continous_time(1+1, 1+ 0) = -(w_mm_^ 2);
A_continous_time(1+1, 1+ 1) = -2.0 * zeta_mm_ * w_mm_;
A_continous_time(1+2, 1+ 3) = 1.0;
A_continous_time(1+3, 1+ 2) = -(w_mm_^  2);
A_continous_time(1+3, 1+ 3) = -2.0 * zeta_mm_ * w_mm_;
A_continous_time(1+4, 1+ 4) = -1.0 / Tgm_;
A_continous_time(1+5, 1+ 5) = -1.0 / Tgm_;
A_continous_time(1+6, 1+ 7) = 1.0;
A_continous_time(1+7, 1:end) = [ 4.536644722616590   0.194598195259296   4.536644722616590   0.194598195259296  0.057081342751919   -0.057081342751919  0                   0  0 0];
A_continous_time(1+8, end) = 1.0;
A_continous_time(1+9, 1:end) = [ 11.2218    0.7430   11.2218    0.7430   0.0019    -0.0019    9.8066         0         0 0];


B_continous_time = zeros(10,4);
B_continous_time(1+1, 1+ 0) = (w_mm_^ 2);
B_continous_time(1+3, 1+ 1) = (w_mm_^ 2);
B_continous_time(1+4, 1+ 2) = 1.0 / Tgm_;
B_continous_time(1+5, 1+ 3) = 1.0 / Tgm_;
B_continous_time(1+7, 1+ 0) = -2.941647306011261;
B_continous_time(1+7, 1+ 1) = -2.941647306011261;
B_continous_time(1+9, 1+ 0) = -11.2310;
B_continous_time(1+9, 1+ 1) = -11.2310;



kSamplingTime = 0.015;
A_dis_calc = expm(kSamplingTime*A_continous_time);

count_integral_A = 10000;
integral_exp_A = 0*A_dis_calc;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_dis_calc = integral_exp_A * B_continous_time;


% A_dis_calc =[    0.4271,    0.0223,         0,         0,         0,         0,         0 ,        0;
%    -8.7243,   -0.1501,         0,         0,         0,         0,         0,         0;
%          0,         0,    0.4271,    0.0223,         0,         0,         0,         0;
%          0,         0,   -8.7243,   -0.1501,         0,         0,         0,         0;
%          0,         0,         0,         0,    0.7300,         0,         0,         0;
%          0,         0,         0,         0,         0,    0.7300,         0,         0;
%     0.0090,    0.0005,    0.0090,    0.0005,    0.0001,   -0.0001,    1.0000,    0.0787;
%     0.1699,    0.0113,    0.1699,    0.0113,    0.0028,   -0.0028,         0 ,   1.0000];
%     
% B_dis_calc =[ 0.5729,         0 ,        0 ,        0;
%     8.7243,         0   ,      0 ,        0;
%          0,    0.5729  ,       0 ,        0;
%          0,    8.7243 ,        0 ,        0;
%          0,         0 ,   0.2700 ,        0;
%          0,         0 ,        0 ,   0.2700;
%    -0.0037,   -0.0037,    0.0000 ,  -0.0000;
%    -0.0347,   -0.0347,    0.0005 ,  -0.0005];


%2.956866535496047e+10 after GA (angle and mass)
pop =1.0e+08*1e-3 *[ 0.008949760000000   9.871404396336743   0.184238235003639   0.124771787525554   0.128288077076258   0.037424940205087 0.110675461551536   9.970770833812228   0.024693805833872 ];

%%after GA params 2.401563857211312e+10 (only angle)
pop =1.0e+08*1e-3 *[   0.029264220000000   9.536478352183382   0.059554929227648   7.520393014974616   0.062548992100116   0.786195239613358 0.015702983598463   9.513954583630372   0.008507672284113];
%%after GA params(new cost functio only angle)
pop= 1.0e+5*[0.009139900000000   8.688512684489472   0.026654892581534   5.190527904499262   0.181184564396795   0.256981570562153 0.011325292272676   9.465709843738091   0.011458832966775];


pop = 1e7*[1.739810177954929                   0   2.504563962151606                   0                   0                   0  0   6.25e3                   0];

%PSO angle s pam?enjem x
pop = 1e7*[0.011112323538018   7.918260215207514                   0   3.431888811914739   0.002917586383233                   0  0   8.009244324116079                   0 ];

% pop = 1e12*[ 0.066088402161949   0.198856562678217   0.003861597091856   1.000000000000000   0.409138144696993   0.974422416565744 0.187334016098564   0.074652094799762                   0];
% 
% %PSO with mass included
% pop = 1e17*[0.2012         0    1.0000         0    0.4877    0.2744         0    0.4768    0.0228];


R =inv(diag([0.5800 0.5800 300 300]))*diag([0, 0, 0, 0])*inv(diag([0.5800 0.5800 300 300]));
R_delta =inv(diag([0.5800 0.5800 300 300]))* diag([0,0,0,0])*inv(diag([0.5800 0.5800 300 300]));
Q = inv(diag([0.5800 4*kSamplingTime 0.5800 4*kSamplingTime 300 300 0.2 (0.2/3) 100 4])) * diag([0, 0, 0, 0, 0, 0, 1e5,0, 1e7, 0]) *inv(diag([0.5800 4*kSamplingTime 0.5800 4*kSamplingTime 300 300 0.2 (0.2/3.0) 100 4]));


sim_time = 200.0;
