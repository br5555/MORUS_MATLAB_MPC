syms ROLL PITCH YAW DOT_ROLL DOT_PITCH DOT_YAW 

matrica = [1 sin(ROLL)*tan(PITCH) cos(ROLL)*tan(PITCH);
           0  cos(ROLL) -sin(ROLL);
           0 sin(ROLL)/cos(PITCH) cos(ROLL)/cos(PITCH)]
       
TF = inv(matrica);
TF = simplify(TF,100);
matricaW = TF*[DOT_ROLL; DOT_PITCH;DOT_YAW]