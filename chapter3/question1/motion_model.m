function [Xt, Pt] = motion_model(Xt_1, ut, Pt_1) 

delT = 1;
R = 1;

At = [1 1; 0 1];
Bt = [delT^2/2; delT];

Xt = At*Xt_1 + Bt*ut;
Pt = At*Pt_1*At' + Bt*R*Bt';

end