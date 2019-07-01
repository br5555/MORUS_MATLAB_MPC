clc
clear all
syms   OMEGA_1 OMEGA_2 OMEGA_3 OMEGA_4 DOT_YAW YAW ROLL PITCH DOT_PITCH DOT_ROLL v_0_x v_0_y v_0_z  x_1 x_3 y_2 y_4 DOT_x_1 DOT_x_3 DOT_y_2 DOT_y_4 x_1_ref x_3_ref y_2_ref y_4_ref  REAL



m = 1.0;
M = 34.8;
L =  0.84;%0.6 %+0.1;
BETA =0.0;%0.0; 11.5*(pi/180);
b_f = 4.56e-4;%(25*9.81)/( (7000/(60*2*pi))^2 );
b_m = 0.01;
g = 9.80665;
I_b_XX = 5.5268;
I_b_YY = 5.5268;
I_b_ZZ = 6.8854;
w_mm = 17;%19.7845;
zeta_mm = 0.85;%0.6544;
m_b = 30.8;
z_r = 0.2;
z_m = 0.05;
T_r = 0.2;%0.25;

zeta_mm = 0.6544;
w_mm = 19.7845;



W_X = DOT_ROLL - DOT_YAW*sin(PITCH);
W_Y =  DOT_PITCH*cos(ROLL) + DOT_YAW*cos(PITCH)*sin(ROLL);
W_Z =  DOT_YAW*cos(PITCH)*cos(ROLL) - DOT_PITCH*sin(ROLL);

MI = m/M;
x13 = x_1 + x_3;
y24 = y_2 +  y_4;


DOT_x13 = DOT_x_1 + DOT_x_3;
DOT_y24 = DOT_y_2 +  DOT_y_4;

DOT_DOT_x_1 = w_mm^2*(x_1_ref - x_1) - 2*zeta_mm*w_mm*DOT_x_1;
DOT_DOT_x_3 = w_mm^2*(x_3_ref - x_3) - 2*zeta_mm*w_mm*DOT_x_3;

DOT_DOT_y_2 = w_mm^2*(y_2_ref - y_2) - 2*zeta_mm*w_mm*DOT_y_2;
DOT_DOT_y_4 = w_mm^2*(y_4_ref - y_4) - 2*zeta_mm*w_mm*DOT_y_4;


DOT_DOT_x13 = DOT_DOT_x_1 + DOT_DOT_x_3;
DOT_DOT_y24 = DOT_DOT_y_2 +  DOT_DOT_y_4;


F_r_1 = b_f * OMEGA_1^2;
F_r_2 = b_f * OMEGA_2^2;
F_r_3 = b_f * OMEGA_3^2;
F_r_4 = b_f * OMEGA_4^2;




M_r_1 = b_m * b_f * OMEGA_1^2;
M_r_2 = b_m * b_f * OMEGA_2^2;
M_r_3 = b_m * b_f * OMEGA_3^2;
M_r_4 = b_m * b_f * OMEGA_4^2;



I_b_c = [ I_b_XX + m_b*( ( MI *y24 )^2 + ( sym(4)*MI*z_m )^2 ) ,  - m_b * MI^2 * x13 * y24                              , sym(-4) * m_b * MI^2 * x13 * z_m                    ;
    - m_b * MI^2 * x13 * y24                            ,  I_b_YY + m_b*( ( MI *x13 )^2 + ( sym(4)*MI*z_m )^2 )  , sym(-4) * m_b * MI^2 * y24 * z_m                    ;
    sym(-4) * m_b * MI^2 * x13 * z_m                     ,  sym(-4) * m_b * MI^2 * y24 * z_m                      , I_b_ZZ + m_b*( ( MI * x13 )^2 + ( MI * y24 )^2 )   ];


I_1_c = [ m *( (MI*y24)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)              , m * MI * ( sym(0.5)*L + x_1 - MI*x13) * y24                          ,  - m * ( sym(0.5)*L + x_1 - MI*x13)*( (1 - sym(4)*MI )*z_m ) ;
    m * MI * ( sym(0.5)*L + x_1 - MI*x13) * y24                 ,  m *( (sym(0.5)*L + x_1 - MI*x13)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)  ,  m* MI* y24 * (1 - sym(4)*MI ) * z_m                         ;
    - m * ( sym(0.5)*L + x_1 - MI*x13)*( (1 - sym(4)*MI )*z_m ) , m* MI* y24 * (1 - sym(4)*MI ) * z_m                                  ,  m *( (sym(0.5)*L + x_1 - MI*x13)^2 + ( MI * y24 )^2)       ];

I_3_c = [ m *( (MI*y24)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)              , m * MI * ( sym(-0.5)*L + x_3 - MI*x13) * y24                          ,  - m * ( sym(-0.5)*L + x_3 - MI*x13)*( (1 - sym(4)*MI )*z_m ) ;
    m * MI * ( sym(-0.5)*L + x_3 - MI*x13) * y24                 ,  m *( (sym(-0.5)*L + x_3 - MI*x13)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)  ,  m* MI* y24 * (1 - sym(4)*MI ) * z_m                         ;
    - m * ( sym(-0.5)*L + x_3 - MI*x13)*( (1 - sym(4)*MI )*z_m ) , m* MI* y24 * (1 - sym(4)*MI ) * z_m                                  ,  m *( (sym(-0.5)*L + x_3 - MI*x13)^2 + ( MI * y24 )^2)       ];

I_2_c = [ m *( ( sym(0.5)*L + y_2 - MI*y24 )^2 + ((sym(1) - sym(4)*MI)*z_m)^2)              , m * MI * ( sym(0.5)*L + y_2 - MI*y24) * x13                                                    ,   m * MI * x13 * ((sym(1) - sym(4)*MI)*z_m)                     ;
    m * MI * ( sym(0.5)*L + y_2 - MI*y24) * x13                                   ,  m *( (MI * x13)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)                                             ,  - m* MI* (sym(0.5)*L + y_2 - MI*y24) * (1 - sym(4)*MI ) * z_m  ;
    m * MI * x13 * ((sym(1) - sym(4)*MI)*z_m)                                    , - m* MI* (sym(0.5)*L + y_2 - MI*y24) * (1 - sym(4)*MI ) * z_m                                  ,  m *( (sym(0.5)*L + y_2 - MI*y24)^2 + ( MI * x13 )^2)          ];


I_4_c = [ m *( ( sym(-0.5)*L + y_4 - MI*y24 )^2 + ((sym(1) - sym(4)*MI)*z_m)^2)              , m * MI * ( sym(-0.5)*L + y_4 - MI*y24) * x13                                                    ,   m * MI * x13 * ((sym(1) - sym(4)*MI)*z_m)                     ;
    m * MI * ( sym(-0.5)*L + y_4 - MI*y24) * x13                                   ,  m *( (MI * x13)^2 + ((sym(1) - sym(4)*MI)*z_m)^2)                                             ,  - m* MI* (sym(-0.5)*L + y_4 - MI*y24) * (1 - sym(4)*MI ) * z_m  ;
    m * MI * x13 * ((sym(1) - sym(4)*MI)*z_m)                                    , - m* MI* (sym(-0.5)*L + y_4 - MI*y24) * (1 - sym(4)*MI ) * z_m                                  ,  m *( (sym(-0.5)*L + y_4 - MI*y24)^2 + ( MI * x13 )^2)          ];


I_S_C =   I_b_c +  I_1_c + I_2_c + I_3_c + I_4_c;



M_e_x = - F_r_1 * cos(BETA) * MI * y24 ...
    - M_r_1 * sin(BETA) ...
    + F_r_2 * ( cos(BETA)*( L - MI*y24) + sin(BETA)*( z_r - sym(4)*MI*z_m)  ) ...
    - F_r_3 * cos(BETA) * MI * y24 ...
    + M_r_3*sin(BETA) ...
    + F_r_4 * ( cos(BETA)*( -L - MI*y24) - sin(BETA)*( z_r - sym(4)*MI*z_m)  );

M_e_y =  F_r_1 * ( cos(BETA)*( -L + MI*x13) - sin(BETA)*( z_r - sym(4)*MI*z_m)  ) ...
    + F_r_2 * cos(BETA) * MI * x13 ...
    + M_r_2 * sin(BETA) ...
    + F_r_3 * ( cos(BETA)*( L + MI*x13) + sin(BETA)*( z_r - sym(4)*MI*z_m)  ) ...
    + F_r_4 * cos(BETA) * MI * x13 ...
    - M_r_4 * sin(BETA);

M_e_z = - F_r_1 * sin(BETA) * MI * y24 ...
    + M_r_1 * cos(BETA) ...
    + F_r_2 * sin(BETA)*MI * x13 ...
    - M_r_2 *cos(BETA) ...
    + F_r_3 * sin(BETA) * MI * y24 ...
    + M_r_3 * cos(BETA) ...
    - F_r_4 * sin(BETA) * MI * x13 ...
    - M_r_4 * cos(BETA);

DOT_W_X = ( 1/I_S_C(1,1) ) * ( ...
    M_e_x - ( I_S_C(3,3) - I_S_C(2,2)) *W_Y * W_Z ...
    -2* m_b *(MI^2) * y24 * DOT_y24 * W_X ...
    -m * L * (DOT_y_2 - DOT_y_4) * W_X ...
    - 2 * m * (DOT_y_2 * y_2  + DOT_y_4 * y_4 )*(1 - 2*MI + 4*MI*MI) * W_X ...
    + 4 * m * (DOT_y_2 * y_4  + DOT_y_4 * y_2 )*(1 -  2*MI)* MI * W_X ...
    + m * W_Z * DOT_x13 * z_m * (1 - 4*MI) ...
    + m * W_Y * MI *( x13 * DOT_y24 - DOT_x13 * y24) ...
    + m * DOT_DOT_y24  * z_m * (1 - 4*MI) ...
    );

DOT_W_Y = ( 1/I_S_C(2,2) ) * ( ...
    M_e_y - ( I_S_C(1,1) - I_S_C(3,3)) *W_X * W_Z ...
    -2* m_b *(MI^2) * x13 * DOT_x13 * W_Y ...
    -m * L * (DOT_x_1 - DOT_x_3) * W_Y ...
    - 2 * m * (DOT_x_1 * x_1  + DOT_x_3 * x_3 )*(1 - 2*MI + 4*MI*MI) * W_Y ...
    + 4 * m * (DOT_x_1 * x_3  + DOT_x_3 * x_1 )*(1 -  2*MI)* MI * W_Y ...
    + m * W_Z * DOT_y24 * z_m * (1 - 4*MI) ...
    + m * W_X * MI *( y24 * DOT_x13 - DOT_y24 * x13) ...
    - m * DOT_DOT_x13  * z_m * (1 - 4*MI) ...
    );


DOT_W_Z = ( 1/I_S_C(3,3) ) * ( ...
    M_e_z - ( I_S_C(2,2) - I_S_C(1,1)) *W_X * W_Y ...
    - 2 * m_b * MI^2 * ( x13 * DOT_x13 + y24 * DOT_y24) * W_Z ...
    - m * L *(DOT_x_1 - DOT_x_3 + DOT_y_2 - DOT_y_4) * W_Z ...
    - 2 * m * (DOT_x_1 * x_1 + DOT_x_3 * x_3 + DOT_y_2 * y_2 + DOT_y_4 * y_4)*(1 - 2*MI + 4*MI^2) * W_Z ...
    + 4 * m *( DOT_x_1 *x_3 + DOT_x_3 * x_1 + DOT_y_2 * y_4 + DOT_y_4 * y_2) * MI *( 1 - 2*MI) * W_Z ...
    - m *( W_X * DOT_x13 + W_Y * DOT_y24) * z_m *(1 - 4*MI) ...
    + m * MI *( x13 * DOT_y24 - DOT_x13 * y24) ...
    );




DOT_DOT_ROLL = DOT_W_X + cos(ROLL)*DOT_ROLL*tan(PITCH)*W_Y + sin(ROLL)*(1/((cos(PITCH))^2))*DOT_PITCH*W_Y + ...
    sin(ROLL)*tan(PITCH)*DOT_W_Y - sin(ROLL)*DOT_ROLL*tan(PITCH)*W_Z + cos(ROLL)*(1/((cos(PITCH))^2))*DOT_PITCH*W_Z + ...
    cos(ROLL)*tan(PITCH)*DOT_W_Z;


rezultat_ROLL = jacobian(DOT_DOT_ROLL, [y_2, DOT_y_2, y_4, DOT_y_4, OMEGA_2, OMEGA_4, ROLL, DOT_ROLL])
ulaz_ROLL = jacobian(DOT_DOT_ROLL, [y_2_ref ,y_4_ref])

ROLL_MAT = [simplify(rezultat_ROLL(1,1),10) ,
    simplify(rezultat_ROLL(1,2),10) ,
    simplify(rezultat_ROLL(1,3),10) ,
    simplify(rezultat_ROLL(1,4),10) ,
    simplify(rezultat_ROLL(1,5),10) ,
    simplify(rezultat_ROLL(1,6),10) ,
    simplify(rezultat_ROLL(1,7),10) ,
    simplify(rezultat_ROLL(1,8),10) ];

ULAZ_ROLL_MAT = [simplify(ulaz_ROLL(1,1),10) ,simplify(ulaz_ROLL(1,2),10)];


DOT_DOT_PITCH = -sin(ROLL)*DOT_ROLL*W_Y + cos(ROLL)*DOT_W_Y - cos(ROLL)*DOT_ROLL*W_Z-sin(ROLL)*DOT_W_Z;
rezultat_PITCH = jacobian(DOT_DOT_PITCH, [x_1, DOT_x_1, x_3, DOT_x_3, OMEGA_1, OMEGA_3, PITCH, DOT_PITCH])
ulaz_PITCH = jacobian(DOT_DOT_PITCH, [x_1_ref ,x_3_ref])

PITCH_MAT = [simplify(rezultat_PITCH(1,1),10) ,
    simplify(rezultat_PITCH(1,2),10) ,
    simplify(rezultat_PITCH(1,3),10) ,
    simplify(rezultat_PITCH(1,4),10) ,
    simplify(rezultat_PITCH(1,5),10) ,
    simplify(rezultat_PITCH(1,6),10) ,
    simplify(rezultat_PITCH(1,7),10) ,
    simplify(rezultat_PITCH(1,8),10) ];
ULAZ_PITCH_MAT = [simplify(ulaz_PITCH(1,1),10) ,simplify(ulaz_PITCH(1,2),10)];

% ajmo1 = subs(rezultat_PITCH, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref], [427.6233, -427.6233, 427.6233, -427.6233, 0,  0, 0, 0, 0 , L/2, -L/2, L/2, -L/2, 0, 0, 0 ,0,0, 0, 0 ,0])
% ajmo1 = double(ajmo1)
% ajmo = subs(ULAZ_PITCH_MAT, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0])
% ajmo = double(ajmo)


DOT_DOT_YAW = ((cos(ROLL)*DOT_ROLL*cos(PITCH) + sin(ROLL)*sin(PITCH)*DOT_PITCH)/((cos(PITCH))^2)) *W_Y + (sin(ROLL)/cos(PITCH))*DOT_W_Y + ...
    ((-sin(ROLL)*DOT_ROLL*cos(PITCH) + cos(ROLL)*sin(PITCH)*DOT_PITCH)/((cos(PITCH))^2)) *W_Z + (cos(ROLL)/cos(PITCH))*DOT_W_Z;

rezultatYAW = jacobian(DOT_DOT_YAW, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, YAW, DOT_YAW]);
YAW_MAT = [simplify(rezultatYAW(1,1),10) ,
    simplify(rezultatYAW(1,2),10) ,
    simplify(rezultatYAW(1,3),10) ,
    simplify(rezultatYAW(1,4),10),
    simplify(rezultatYAW(1,5),10) ,
    simplify(rezultatYAW(1,6),10)];



DOT_V_Z =  (1/M)*(F_r_1 + F_r_2 + F_r_3 + F_r_4)*cos(BETA) - g*cos(ROLL)*cos(PITCH) ...
    + MI*W_Y* DOT_x13 - MI*W_X*DOT_y24 ...
    + 4*MI*(W_X^2 + W_Y^2)*z_m + MI*x13*(DOT_W_Y - W_X*W_Z) - MI*(y24)*(DOT_W_X + W_Y*W_Z) ...
    + MI*(W_Y*DOT_x13 - W_X*DOT_y24) ...
    + v_0_x*W_Y - v_0_y*W_X;

rezultatZ = jacobian(DOT_V_Z, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4]);
Z_MAT = [simplify(rezultatZ(1,1),10) ,
    simplify(rezultatZ(1,2),10) ,
    simplify(rezultatZ(1,3),10) ,
    simplify(rezultatZ(1,4),10)];

%
DOT_V_X = (1/M)*(F_r_3  - F_r_1)*sin(BETA) + g*sin(PITCH) ...
           -MI*DOT_DOT_x13 + MI*W_Z*DOT_y24 ...
           +MI*(W_Y^2 + W_Z^2)*(x13) + MI*y24*(DOT_W_Z - W_X * W_Y) ...
           - 4*MI*DOT_W_Y *z_m + MI * W_Z *( DOT_y24 - 4* W_X * z_m) ...
           + v_0_y * W_Z - v_0_z * W_Y ;

v_x_rezultat = jacobian(DOT_V_X, [x_1, DOT_x_1, x_3, DOT_x_3, OMEGA_1, OMEGA_3, PITCH, DOT_PITCH, v_0_x ])
ulaz_v_x = jacobian(DOT_V_X, [x_1_ref ,x_3_ref])

ajmo = subs(v_x_rezultat, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref, v_0_z], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0,0])
ajmo = double(ajmo)


ajmo2 = subs(ulaz_v_x, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref, v_0_z], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0,0])
ajmo2 = double(ajmo2)

%%
DOT_V_Y = (1/M)*(F_r_4  - F_r_2)*sin(BETA) - g*cos(PITCH)*sin(ROLL) ...
           -MI*DOT_DOT_y24 - MI*W_Z*DOT_x13 ...
           +MI*(W_X^2 + W_Z^2)*(y24) - MI*x13*(DOT_W_Z + W_X * W_Y) ...
           + 4*MI*DOT_W_X*z_m - MI*W_Z *( DOT_x13 + 4* W_Y * z_m) ...
           + v_0_z * W_X - v_0_x * W_Z ;

v_y_rezultat = jacobian(DOT_V_Y, [y_2, DOT_y_2, y_4, DOT_y_4, OMEGA_2, OMEGA_4, ROLL, DOT_ROLL, v_0_y ])
ulaz_v_y = jacobian(DOT_V_Y, [y_2_ref ,y_4_ref])

ajmo = subs(v_y_rezultat, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref, v_0_z], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0,0])
ajmo = double(ajmo)


ajmo2 = subs(ulaz_v_y, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref, v_0_z], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0,0])
ajmo2 = double(ajmo2)

%%
ajmo2 = subs(PITCH_MAT, [OMEGA_1, OMEGA_2, OMEGA_3, OMEGA_4, DOT_YAW , ROLL, PITCH, DOT_PITCH, DOT_ROLL,  x_1, x_3, y_2, y_4, DOT_x_1 ,DOT_x_3 ,DOT_y_2, DOT_y_4, x_1_ref, x_3_ref, y_2_ref, y_4_ref, v_0_z], [427.6233, 427.6233, 427.6233, 427.6233, 0,  0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 ,0,0, 0, 0 ,0,0])
ajmo2 = double(ajmo2)