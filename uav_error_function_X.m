function cost_func = uav_error_function(pop)

m = 1.0;
M = 34;%34.8;
L =  0.84;%0.6 %+0.1;
BETA = 0;
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



digits(50)
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
A_continous_time(1+7, 1+ 0) = 1.0 * mass_ / Iyy_ * (kGravity + ((1.0 - 4.0 * mi_) * zm_ * (w_mm_^ 2)));
A_continous_time(1+7, 1+ 1) = 2.0 * mass_ * (1.0 - 4.0 * mi_) * zm_ * zeta_mm_ * w_mm_ / Iyy_;
A_continous_time(1+7, 1+ 2) = mass_ / Iyy_ * (kGravity + ((1.0 - 4.0 * mi_) * zm_ * (w_mm_^ 2)));
A_continous_time(1+7, 1+ 3) = 2.0 * mass_ * (1.0 - 4.0 * mi_) * zm_ * zeta_mm_ * w_mm_ / Iyy_;
A_continous_time(1+7, 1+ 4) = 2 * b_gm_f_ * w_gm_0_ * lm_ / Iyy_;
A_continous_time(1+7, 1+ 5) = -2 * b_gm_f_ * w_gm_0_ * lm_ / Iyy_;
A_continous_time(1+8, end) = 1.0;
A_continous_time(1+9, 1:end) = [ 11.2216    0.7430   11.2216    0.7430   0.0003    -0.0003    9.8066         0         0  0];


B_continous_time = zeros(10,4);
B_continous_time(1+1, 1+ 0) = (w_mm_^ 2);
B_continous_time(1+3, 1+ 1) = (w_mm_^ 2);
B_continous_time(1+4, 1+ 2) = 1.0 / Tgm_;
B_continous_time(1+5, 1+ 3) = 1.0 / Tgm_;
B_continous_time(1+7, 1+ 0) = -2.941647306011261;
B_continous_time(1+7, 1+ 1) = -2.941647306011261;
B_continous_time(1+9, 1+ 0) = -11.2310;
B_continous_time(1+9, 1+ 1) = -11.2310;




kSamplingTime = 0.0400;
A_dis_calc = expm(kSamplingTime*A_continous_time);

count_integral_A = 1000;
integral_exp_A = 0*A_dis_calc;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_dis_calc = integral_exp_A * B_continous_time;
cost_func = 0.0;


sim_time = 50.0;
warning('off','all');

R =inv(diag([0.5800 0.5800 300 300]))*diag([pop(1),pop(1),pop(2), pop(2)])*inv(diag([0.5800 0.5800 300 300]));
R_delta =inv(diag([0.5800 0.5800 300 300]))* diag([pop(3),pop(3) ,pop(4),pop(4)])*inv(diag([0.5800 0.5800 300 300]));
Q = inv(diag([0.5800 4*kSamplingTime 0.5800 4*kSamplingTime 300 300 0.2 (0.2/3) 100 4])) * diag([pop(5),pop(6),pop(5),pop(6), pop(7),pop(7) ,pop(8),pop(9),pop(10),pop(11)]) *inv(diag([0.5800 4*kSamplingTime 0.5800 4*kSamplingTime 300 300 0.2 (0.2/3.0) 100 4]));

    try
        
        options = simset('SrcWorkspace','current');
        simOut = sim('MORUS_NELINEARNI_MPC_X',[],options);
%         cost1 = sum(abs(preb_GA.signals.values) )*1e6
%         cost2 = 1e9*sum(abs(error_roll.signals.values))
%         cost3 = (sim_time- simOut(end))*1e9
%         cost4 = sum(abs(masa_1.signals.values))*1e9 +sum(abs(masa_2.signals.values))*1e9
        cost_func =cost_func + 1e11*sum(abs(error_y.signals.values))  +sum(abs(preb_GA2.signals.values) )*5e6  ;
        if((simOut(end)+1) < sim_time)
            cost_func = 1e52;
        
            return;
        end
    catch ME
        cost_func = 1e52;
        
        return;
    end
    


end

