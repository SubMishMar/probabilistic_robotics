function [Xt] = motion_model(Xt_1, u)
theta = Xt_1(3);
c = cos(theta);
s = sin(theta);

x = Xt_1(1);
y = Xt_1(2);
tht = Xt_1(3);

d = u(1);
omega = u(2);

Xt = [x + d*cos(tht);
      y + d*sin(tht);
      tht + omega];
end