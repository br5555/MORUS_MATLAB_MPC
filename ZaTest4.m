clc 
clear all

Tgm_ = 0.25;
R_Z =diag([0, 0,0,0]);
R_delta_Z = diag([0, 0,0,0]);
Q_Z = diag([ 0.002706800, 0.002706800, 0.002706800, 0.002706800,1, 5.0]);
kSamplingTime = 0.189;

A_continous_time = zeros(6,6);
A_continous_time(1, 1) = -1.0 / Tgm_;
A_continous_time(2, 2) = -1.0 / Tgm_;
A_continous_time(3, 3) = -1.0 / Tgm_;
A_continous_time(4, 4) = -1.0 / Tgm_;
A_continous_time(5, 6) =1.0 ;
A_continous_time(6, :)  =[0.011206679586207; 0.011206679586207; 0.011206679586207; 0.011206679586207; 0; 0];


B_continous_time = zeros(6,4);
B_continous_time(1, 1) = 1.0 / Tgm_;
B_continous_time(2, 2) = 1.0 / Tgm_;
B_continous_time(3, 3) = 1.0 / Tgm_;
B_continous_time(4, 4) = 1.0 / Tgm_;


A_Z = expm(kSamplingTime*A_continous_time);

count_integral_A = 10000;
integral_exp_A = 0*A_Z;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_Z = integral_exp_A * B_continous_time;
C = eye(6);
D = zeros(size(B_Z));


[d,n] = ss2tf(A_continous_time, B_continous_time, C, D, 1)
S1 = stepinfo(tf2ss(d,n));

[d,n] = ss2tf(A_continous_time, B_continous_time, C, D, 2)
S2 = stepinfo(tf2ss(d,n));

[d,n] = ss2tf(A_continous_time, B_continous_time, C, D, 3)
S3 = stepinfo(tf2ss(d,n));

[d,n] = ss2tf(A_continous_time, B_continous_time, C, D, 4)
S4 = stepinfo(tf2ss(d,n));
Mat_rise = [S1.RiseTime, S2.RiseTime, S3.RiseTime, S4.RiseTime];
Tr_best = min(Mat_rise(Mat_rise > 0));
Ts_best = Tr_best/10

Mat_Sett = [S1.SettlingTime, S2.SettlingTime, S3.SettlingTime, S4.SettlingTime];
T_settling_best = min(Mat_Sett(Mat_Sett > 0))
p = round(T_settling_best/Ts_best)

m = round(0.15*p)

wb1 =  bandwidth(ss2tf(A_continous_time, B_continous_time, C, D, 1));
wb2 =  bandwidth(ss2tf(A_continous_time, B_continous_time, C, D, 2));
wb3 =  bandwidth(ss2tf(A_continous_time, B_continous_time, C, D, 3));
wb4 =  bandwidth(ss2tf(A_continous_time, B_continous_time, C, D, 4));

wb = max([wb1, wb2, wb3, wb4]);

T_s_band = (0.5)/wb


t1 = 3.7182 * 5;


t2 = 7.1656* 5;


t3 =3.7182* 5;


t4 =0


t5 = 3.7182* 5;


t6 = 7.1656* 5;


t7 = 3.7182* 5;
