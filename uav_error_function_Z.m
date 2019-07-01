function cost_func = uav_error_function_Z(pop)

m = 1.0;
M = 34;%34.8;
L =  0.84;%0.6 %+0.1;
BETA = 0.0;
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



%PSO angle s pam?enjem x
pop_ROLL = 1e7*[0.011112323538018   7.918260215207514                   0   3.431888811914739   0.002917586383233                   0  0   8.009244324116079                   0 ];

% pop = 1e12*[ 0.066088402161949   0.198856562678217   0.003861597091856   1.000000000000000   0.409138144696993   0.974422416565744 0.187334016098564   0.074652094799762                   0];
% 
% %PSO with mass included
% pop = 1e17*[0.2012         0    1.0000         0    0.4877    0.2744         0    0.4768    0.0228];


R =diag([pop_ROLL(1),pop_ROLL(1),pop_ROLL(2),pop_ROLL(2)]);
R_delta = diag([pop_ROLL(3),pop_ROLL(3),pop_ROLL(4),pop_ROLL(4)]);
Q = diag([pop_ROLL(5),pop_ROLL(6),pop_ROLL(5),pop_ROLL(6), pop_ROLL(7),pop_ROLL(7),pop_ROLL(8),pop_ROLL(9)]);




kontanta_rotori = 0.0112;%kGravity/(4*hover);

A_continous_time_Z = zeros(6,6);
A_continous_time_Z(1, 1) = -1.0 / Tgm_;
A_continous_time_Z(2, 2) = -1.0 / Tgm_;
A_continous_time_Z(3, 3) = -1.0 / Tgm_;
A_continous_time_Z(4, 4) = -1.0 / Tgm_;
A_continous_time_Z(5, 6) =1.0 ;
A_continous_time_Z(6, :)  =[kontanta_rotori kontanta_rotori kontanta_rotori kontanta_rotori 0 0];



B_continous_time_Z = zeros(6,4);
B_continous_time_Z(1, 1) = 1.0 / Tgm_;
B_continous_time_Z(2, 2) = 1.0 / Tgm_;
B_continous_time_Z(3, 3) = 1.0 / Tgm_;
B_continous_time_Z(4, 4) = 1.0 / Tgm_;


kSamplingTime_Z = 0.81;
A_dis_calc_Z = expm(kSamplingTime_Z*A_continous_time_Z);

count_integral_A = 10000;
integral_exp_A_Z = 0*A_dis_calc_Z;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A_Z = (integral_exp_A_Z + expm((A_continous_time_Z * kSamplingTime_Z * i / count_integral_A)) ...
        * kSamplingTime_Z / count_integral_A);
end


B_dis_calc_Z = integral_exp_A_Z * B_continous_time_Z;

B_gravity_continous_time_Z = zeros(6,1);
B_gravity_continous_time_Z(6,1) = -9.81;
B_gravity_dis_calc_Z = integral_exp_A_Z * B_gravity_continous_time_Z;







R_Z =inv(diag([600 600 600 600]))*diag([pop(1), pop(1), pop(1), pop(1)])  * inv(diag([600 600 600 600]));
R_delta_Z = inv(diag([600 600 600 600]))* diag([pop(2),pop(2), pop(2),pop(2)])  * inv(diag([600 600 600 600]));
Q_Z = inv(diag([600 600 600 600 15 3]))* diag([pop(3),pop(3),pop(3),pop(3),pop(4), pop(5)]) * inv(diag([600 600 600 600 15 3]));

cost_func = 0.0;



sim_time = 60.0;
warning('off','all');


    try
        
        options = simset('SrcWorkspace','current');
        simOut = sim('MORUS_NELINEARNI_MPC_Z_Linearni',[],options);
%         cost1 = sum(abs(preb_GA.signals.values) )*1e6
%         cost2 = 1e9*sum(abs(error_roll.signals.values))
%         cost3 = (sim_time- simOut(end))*1e9
%         cost4 = sum(abs(masa_1.signals.values))*1e9 +sum(abs(masa_2.signals.values))*1e9
        cost_func =cost_func + 1e10*sum(abs(error_Z.signals.values))  +sum(abs(preb_GA2.signals.values) )*5e5 + (sim_time- simOut(end))*1e9 ;
%         cost_func =cost_func + 1e9*sum(abs(error_roll.signals.values))  +sum(abs(preb_GA.signals.values) )*5e6 + (sim_time- simOut(end))*1e9;
        if((simOut(end)+1) < sim_time)
            cost_func = 1e49;
        
            return;
        end
    catch ME
        cost_func = 1e49;
        
        return;
    end
    


end

