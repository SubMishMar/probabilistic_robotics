function Xt = motion_model_lin(Xt_1, u)
d = u(1);
theta = Xt_1(3);

At = [1 0 -d*sin(theta);
      0 1  d*cos(theta);
      0 0  1];
  
Bt = [cos(theta) 0;
      sin(theta) 0;
              0  1];
          
Xt = At*Xt_1 + Bt*u;
end