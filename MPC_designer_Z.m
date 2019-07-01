clc
clear all
close all
Tgm_ = 0.25;
kSamplingTime = 0.81;
kontanta_rotori = 0.0057;

A_continous_time = zeros(6,6);
A_continous_time(1, 1) = -1.0 / Tgm_;
A_continous_time(2, 2) = -1.0 / Tgm_;
A_continous_time(3, 3) = -1.0 / Tgm_;
A_continous_time(4, 4) = -1.0 / Tgm_;
A_continous_time(5, 6) =1.0 ;
A_continous_time(6, :)  =[kontanta_rotori kontanta_rotori kontanta_rotori kontanta_rotori 0 0];


B_continous_time = zeros(6,4);
B_continous_time(1, 1) = 1.0 / Tgm_;
B_continous_time(2, 2) = 1.0 / Tgm_;
B_continous_time(3, 3) = 1.0 / Tgm_;
B_continous_time(4, 4) = 1.0 / Tgm_;


A_YAW = expm(kSamplingTime*A_continous_time);

count_integral_A = 10000;
integral_exp_A = 0*A_YAW;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_YAW = integral_exp_A * B_continous_time;
C = eye(10)
D = 0*B_continous_time;

morus_cont = ss(A_continous_time, B_continous_time, C, D);
morus_disk = c2d(morus_cont, kSamplingTime);
mpcDesigner(morus_disk)