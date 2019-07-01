function [A_dis_calc ,B_dis_calc] = getPITCHMAT(OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW,  ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1, DOT_x_3, DOT_y_2, DOT_y_4, DOT_DOT_x_1 ,DOT_DOT_x_3 , DOT_DOT_y_2, DOT_DOT_y_4, kSamplingTime)

kGravity = 9.80665;
mass_ = 1.0;
mass_quad_ = 30.8;
M_ = mass_quad_ + 4 * mass_;
mi_ = mass_ / M_;

zm_ = 0.05;

lm_ = 0.6;
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

w_gm_0_ = sqrt(M_ * kGravity / 4.0 / b_gm_f_);





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


A_continous_time(8,:)= [(108750*cos(ROLL)*((3504881374004815*OMEGA_1^2)/267477789068788498432 + (3504881374004815*OMEGA_2^2)/267477789068788498432 + (3504881374004815*OMEGA_3^2)/267477789068788498432 + (3504881374004815*OMEGA_4^2)/267477789068788498432 - (14318*DOT_x_1*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)))/7569 + (820*DOT_x_3*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)))/7569 - ((5*DOT_ROLL)/174 - (5*DOT_YAW*sin(PITCH))/174)*(DOT_y_2 + DOT_y_4) - ((385*DOT_x_1)/7569 + (385*DOT_x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) - (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((169*x_1)/87 - (5*x_3)/87 + 21/25)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369) - (87000*sin(ROLL)*((5*DOT_y_2)/174 + (5*DOT_y_4)/174 + (14318*DOT_x_1*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)))/7569 - (820*DOT_x_3*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)))/7569 + ((385*DOT_x_1)/7569 + (385*DOT_x_3)/7569)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) - (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*((169*x_1)/87 - (5*x_3)/87 + 21/25)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417) - (7569000000*sin(ROLL)*((169*x_1)/87 - (5*x_3)/87 + 21/25)*((1345874447617849*OMEGA_2^2)/295147905179352825856 + (1345874447617849*OMEGA_4^2)/295147905179352825856 + (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569 + (820*DOT_y_2*y_4)/7569 + (820*DOT_y_4*y_2)/7569) - (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569 + (14318*DOT_y_2*y_2)/7569 + (14318*DOT_y_4*y_4)/7569) + (DOT_ROLL - DOT_YAW*sin(PITCH))*((77*DOT_x_1)/1740 + (77*DOT_x_3)/1740) - (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((21*DOT_x_1)/25 - (21*DOT_x_3)/25 + (21*DOT_y_2)/25 - (21*DOT_y_4)/25) - (5*(x_1 + x_3)*(DOT_y_2 + DOT_y_4))/174 + (5*(y_2 + y_4)*(DOT_x_1 + DOT_x_3))/174 - (1345874447617849*OMEGA_1^2)/295147905179352825856 - (1345874447617849*OMEGA_3^2)/295147905179352825856 - ((385*(x_1 + x_3)*(DOT_x_1 + DOT_x_3))/7569 + (385*(y_2 + y_4)*(DOT_y_2 + DOT_y_4))/7569)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) + ((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 - (169*y_2^2)/174 + (5*y_2*y_4)/87 - (21*y_2)/25 - (169*y_4^2)/174 + (21*y_4)/25)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417)^2 + (11826562500*cos(ROLL)*((169*x_1)/87 - (5*x_3)/87 + 21/25)*((77*DOT_DOT_x_1)/1740 + (77*DOT_DOT_x_3)/1740 - (2102928824402889*OMEGA_1^2*((5*x_1)/174 + (5*x_3)/174 - 21/25))/4611686018427387904 - (2102928824402889*OMEGA_3^2*((5*x_1)/174 + (5*x_3)/174 + 21/25))/4611686018427387904 + ((5*DOT_ROLL)/174 - (5*DOT_YAW*sin(PITCH))/174)*((x_1 + x_3)*(DOT_y_2 + DOT_y_4) - (y_2 + y_4)*(DOT_x_1 + DOT_x_3)) - (3504881374004815*OMEGA_2^2*(x_1 + x_3))/267477789068788498432 - (3504881374004815*OMEGA_4^2*(x_1 + x_3))/267477789068788498432 - ((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((21*DOT_x_1)/25 - (21*DOT_x_3)/25)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 + 740609/435000) + ((385*x_1)/7569 + (385*x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*(DOT_x_1 + DOT_x_3)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)^2
 (10*sin(ROLL)*(385*DOT_ROLL + 250*y_2 + 250*y_4 - 385*DOT_YAW*sin(PITCH) - 7308*DOT_PITCH*sin(ROLL) + 7308*DOT_YAW*cos(PITCH)*cos(ROLL) - 16900*DOT_PITCH*x_1*sin(ROLL) + 500*DOT_PITCH*x_3*sin(ROLL) + 16900*DOT_YAW*x_1*cos(PITCH)*cos(ROLL) - 500*DOT_YAW*x_3*cos(PITCH)*cos(ROLL)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417) - (25*cos(ROLL)*(3654*DOT_PITCH*cos(ROLL) - 125*DOT_ROLL*y_4 - 125*DOT_ROLL*y_2 + 3654*DOT_YAW*cos(PITCH)*sin(ROLL) + 8450*DOT_PITCH*x_1*cos(ROLL) - 250*DOT_PITCH*x_3*cos(ROLL) + 125*DOT_YAW*y_2*sin(PITCH) + 125*DOT_YAW*y_4*sin(PITCH) + 8450*DOT_YAW*x_1*cos(PITCH)*sin(ROLL) - 250*DOT_YAW*x_3*cos(PITCH)*sin(ROLL)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)
 (108750*cos(ROLL)*((3504881374004815*OMEGA_1^2)/267477789068788498432 + (3504881374004815*OMEGA_2^2)/267477789068788498432 + (3504881374004815*OMEGA_3^2)/267477789068788498432 + (3504881374004815*OMEGA_4^2)/267477789068788498432 + (820*DOT_x_1*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)))/7569 - (14318*DOT_x_3*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)))/7569 - ((5*DOT_ROLL)/174 - (5*DOT_YAW*sin(PITCH))/174)*(DOT_y_2 + DOT_y_4) - ((385*DOT_x_1)/7569 + (385*DOT_x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((5*x_1)/87 - (169*x_3)/87 + 21/25)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369) - (87000*sin(ROLL)*((5*DOT_y_2)/174 + (5*DOT_y_4)/174 - (820*DOT_x_1*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)))/7569 + (14318*DOT_x_3*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)))/7569 + ((385*DOT_x_1)/7569 + (385*DOT_x_3)/7569)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*((5*x_1)/87 - (169*x_3)/87 + 21/25)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417) + (7569000000*sin(ROLL)*((5*x_1)/87 - (169*x_3)/87 + 21/25)*((1345874447617849*OMEGA_2^2)/295147905179352825856 + (1345874447617849*OMEGA_4^2)/295147905179352825856 + (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569 + (820*DOT_y_2*y_4)/7569 + (820*DOT_y_4*y_2)/7569) - (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569 + (14318*DOT_y_2*y_2)/7569 + (14318*DOT_y_4*y_4)/7569) + (DOT_ROLL - DOT_YAW*sin(PITCH))*((77*DOT_x_1)/1740 + (77*DOT_x_3)/1740) - (DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((21*DOT_x_1)/25 - (21*DOT_x_3)/25 + (21*DOT_y_2)/25 - (21*DOT_y_4)/25) - (5*(x_1 + x_3)*(DOT_y_2 + DOT_y_4))/174 + (5*(y_2 + y_4)*(DOT_x_1 + DOT_x_3))/174 - (1345874447617849*OMEGA_1^2)/295147905179352825856 - (1345874447617849*OMEGA_3^2)/295147905179352825856 - ((385*(x_1 + x_3)*(DOT_x_1 + DOT_x_3))/7569 + (385*(y_2 + y_4)*(DOT_y_2 + DOT_y_4))/7569)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) + ((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 - (169*y_2^2)/174 + (5*y_2*y_4)/87 - (21*y_2)/25 - (169*y_4^2)/174 + (21*y_4)/25)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417)^2 - (11826562500*cos(ROLL)*((5*x_1)/87 - (169*x_3)/87 + 21/25)*((77*DOT_DOT_x_1)/1740 + (77*DOT_DOT_x_3)/1740 - (2102928824402889*OMEGA_1^2*((5*x_1)/174 + (5*x_3)/174 - 21/25))/4611686018427387904 - (2102928824402889*OMEGA_3^2*((5*x_1)/174 + (5*x_3)/174 + 21/25))/4611686018427387904 + ((5*DOT_ROLL)/174 - (5*DOT_YAW*sin(PITCH))/174)*((x_1 + x_3)*(DOT_y_2 + DOT_y_4) - (y_2 + y_4)*(DOT_x_1 + DOT_x_3)) - (3504881374004815*OMEGA_2^2*(x_1 + x_3))/267477789068788498432 - (3504881374004815*OMEGA_4^2*(x_1 + x_3))/267477789068788498432 - ((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((21*DOT_x_1)/25 - (21*DOT_x_3)/25)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL)) + ((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL)) + (DOT_ROLL - DOT_YAW*sin(PITCH))*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 + 740609/435000) + ((385*x_1)/7569 + (385*x_3)/7569)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*(DOT_x_1 + DOT_x_3)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)^2
 (10*sin(ROLL)*(385*DOT_ROLL + 250*y_2 + 250*y_4 - 385*DOT_YAW*sin(PITCH) + 7308*DOT_PITCH*sin(ROLL) - 7308*DOT_YAW*cos(PITCH)*cos(ROLL) + 500*DOT_PITCH*x_1*sin(ROLL) - 16900*DOT_PITCH*x_3*sin(ROLL) - 500*DOT_YAW*x_1*cos(PITCH)*cos(ROLL) + 16900*DOT_YAW*x_3*cos(PITCH)*cos(ROLL)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417) + (25*cos(ROLL)*(125*DOT_ROLL*y_2 + 125*DOT_ROLL*y_4 + 3654*DOT_PITCH*cos(ROLL) + 3654*DOT_YAW*cos(PITCH)*sin(ROLL) + 250*DOT_PITCH*x_1*cos(ROLL) - 8450*DOT_PITCH*x_3*cos(ROLL) - 125*DOT_YAW*y_2*sin(PITCH) - 125*DOT_YAW*y_4*sin(PITCH) + 250*DOT_YAW*x_1*cos(PITCH)*sin(ROLL) - 8450*DOT_YAW*x_3*cos(PITCH)*sin(ROLL)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)
 (114346754826907089375*OMEGA_1*cos(ROLL)*((5*x_1)/174 + (5*x_3)/174 - 21/25))/(1152921504606846976*(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)) - (14636384617844107875*OMEGA_1*sin(ROLL))/(18446744073709551616*(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417))
 (114346754826907089375*OMEGA_3*cos(ROLL)*((5*x_1)/174 + (5*x_3)/174 + 21/25))/(1152921504606846976*(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369)) - (14636384617844107875*OMEGA_3*sin(ROLL))/(18446744073709551616*(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417))
 (108750*cos(ROLL)*((5*DOT_YAW*cos(PITCH)*((x_1 + x_3)*(DOT_y_2 + DOT_y_4) - (y_2 + y_4)*(DOT_x_1 + DOT_x_3)))/174 - (77*DOT_YAW*cos(ROLL)*sin(PITCH)*(DOT_y_2 + DOT_y_4))/1740 - DOT_YAW*sin(PITCH)*sin(ROLL)*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569) + DOT_YAW*sin(PITCH)*sin(ROLL)*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569) + DOT_YAW*sin(PITCH)*sin(ROLL)*((21*DOT_x_1)/25 - (21*DOT_x_3)/25) + DOT_YAW*cos(PITCH)*(DOT_PITCH*sin(ROLL) - DOT_YAW*cos(PITCH)*cos(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 + 740609/435000) + DOT_YAW*sin(PITCH)*sin(ROLL)*((385*x_1)/7569 + (385*x_3)/7569)*(DOT_x_1 + DOT_x_3) - DOT_YAW*cos(ROLL)*sin(PITCH)*(DOT_ROLL - DOT_YAW*sin(PITCH))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 + 740609/435000)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369) - (87000*sin(ROLL)*((77*DOT_YAW*cos(PITCH)*(DOT_x_1 + DOT_x_3))/1740 + DOT_YAW*cos(ROLL)*sin(PITCH)*((21*DOT_x_1)/25 - (21*DOT_x_3)/25 + (21*DOT_y_2)/25 - (21*DOT_y_4)/25) + (77*DOT_YAW*sin(PITCH)*sin(ROLL)*(DOT_y_2 + DOT_y_4))/1740 + DOT_YAW*cos(PITCH)*(DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 - (21*y_2)/25 + (21*y_4)/25 + (5*y_2*y_4)/87 - (169*y_2^2)/174 - (169*y_4^2)/174) + DOT_YAW*cos(ROLL)*sin(PITCH)*((385*(x_1 + x_3)*(DOT_x_1 + DOT_x_3))/7569 + (385*(y_2 + y_4)*(DOT_y_2 + DOT_y_4))/7569) - DOT_YAW*cos(ROLL)*sin(PITCH)*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569 + (820*DOT_y_2*y_4)/7569 + (820*DOT_y_4*y_2)/7569) + DOT_YAW*cos(ROLL)*sin(PITCH)*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569 + (14318*DOT_y_2*y_2)/7569 + (14318*DOT_y_4*y_4)/7569) + DOT_YAW*sin(PITCH)*sin(ROLL)*(DOT_ROLL - DOT_YAW*sin(PITCH))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 - (21*y_2)/25 + (21*y_4)/25 + (5*y_2*y_4)/87 - (169*y_2^2)/174 - (169*y_4^2)/174)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417) + DOT_YAW*DOT_ROLL*cos(ROLL)^2*sin(PITCH) + DOT_YAW*DOT_ROLL*sin(PITCH)*sin(ROLL)^2
- (108750*cos(ROLL)*(cos(ROLL)*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569) - cos(ROLL)*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569) + cos(ROLL)*((21*DOT_x_1)/25 - (21*DOT_x_3)/25) + sin(ROLL)*((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740) + cos(ROLL)*((385*x_1)/7569 + (385*x_3)/7569)*(DOT_x_1 + DOT_x_3) + sin(ROLL)*(DOT_ROLL - DOT_YAW*sin(PITCH))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 + 740609/435000)))/(105625*x_1^2 - 6250*x_1*x_3 + 91350*x_1 + 105625*x_3^2 - 91350*x_3 + 640369) - (87000*sin(ROLL)*(sin(ROLL)*((21*DOT_x_1)/25 - (21*DOT_x_3)/25 + (21*DOT_y_2)/25 - (21*DOT_y_4)/25) + sin(ROLL)*((385*(x_1 + x_3)*(DOT_x_1 + DOT_x_3))/7569 + (385*(y_2 + y_4)*(DOT_y_2 + DOT_y_4))/7569) - cos(ROLL)*((77*DOT_y_2)/1740 + (77*DOT_y_4)/1740) - sin(ROLL)*((820*DOT_x_1*x_3)/7569 + (820*DOT_x_3*x_1)/7569 + (820*DOT_y_2*y_4)/7569 + (820*DOT_y_4*y_2)/7569) + sin(ROLL)*((14318*DOT_x_1*x_1)/7569 + (14318*DOT_x_3*x_3)/7569 + (14318*DOT_y_2*y_2)/7569 + (14318*DOT_y_4*y_4)/7569) - cos(ROLL)*(DOT_ROLL - DOT_YAW*sin(PITCH))*((169*x_1^2)/174 - (5*x_1*x_3)/87 + (21*x_1)/25 + (169*x_3^2)/174 - (21*x_3)/25 - (21*y_2)/25 + (21*y_4)/25 + (5*y_2*y_4)/87 - (169*y_2^2)/174 - (169*y_4^2)/174)))/(84500*x_1^2 - 5000*x_1*x_3 + 73080*x_1 + 84500*x_3^2 - 73080*x_3 + 84500*y_2^2 - 5000*y_2*y_4 + 73080*y_2 + 84500*y_4^2 - 73080*y_4 + 660417)
];




A_dis_calc = expm(kSamplingTime*A_continous_time);

count_integral_A = 10000;
integral_exp_A = 0*A_dis_calc;

%approximation of integration
for i = 1: count_integral_A
    integral_exp_A = (integral_exp_A + expm((A_continous_time * kSamplingTime * i / count_integral_A)) ...
        * kSamplingTime / count_integral_A);
end


B_dis_calc = integral_exp_A * B_continous_time;