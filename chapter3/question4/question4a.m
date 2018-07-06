clear all;
close all;
clc;
Xt = [0; 0; 0];
XT = Xt;
u = [1; 1];
P = diag([0.01, 0.01, 10000]);

d = u(1);
theta = Xt(3);
At = [1 0 -d*sin(theta);
      0 1  d*cos(theta);
      0 0  1];
  
Bt = [cos(theta) 0;
      sin(theta) 0;
              0  1];
         
Ct = [1 0 0];

Q = 0.01;

r = [0 0 0];
R = diag(r);

x = []; y = []; tht = [];
x_true = x; y_true = y;
tht_true = tht;
Pxx = [];
Pxx = [Pxx, P(1,1)];
Pyy = [];
Pyy = [Pyy, P(2,2)];
Pththt = [];
Pththt = [Pththt, P(3,3)];
for i = 1:100
    XT = motion_model(XT, u) + sqrt(r).*randn(3,1);
    Xt = motion_model(Xt, u);
    P = At*P*At' + R;
    K = P*Ct'/(Ct*P*Ct' + Q);
    ztrue = Ct*XT + sqrt(Q)*randn(1,1);
    Xt = Xt + K*(ztrue -Ct*Xt);
    P = (eye(3) - K*Ct)*P;
    x = [x Xt(1)];
    y = [y Xt(2)];
    tht = [tht Xt(3)];
    x_true = [x_true XT(1)];
    y_true = [y_true XT(2)];
    tht_true = [tht_true XT(3)];
    Pxx = [Pxx, P(1,1)];
    Pyy = [Pyy, P(2,2)];
    Pththt = [Pththt, P(3,3)];
end

figure(1)
plot(1:i, x);
hold on;
plot(1:i, x_true);
hold off;
grid;

figure(2)
plot(1:i, y);
hold on;
plot(1:i, y_true);
hold off;
grid;

figure(3)
plot(1:i, tht);
hold on;
plot(1:i, tht_true);
hold off;
grid;

figure(4);
subplot(311)
plot(1:i+1, Pxx);
grid;
subplot(312)
plot(1:i+1, Pyy);
grid;
subplot(313)
plot(1:i+1, Pththt);
grid;