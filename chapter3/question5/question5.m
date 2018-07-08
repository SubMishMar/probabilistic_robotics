clear all;
close all;
clc;

Xt = zeros(3, 1);
XTruet = Xt;
XTruet(2) = 2;
XTruet(3) = 10;
ut = 1;

At = 1; Bt = 1; Ct =1;
Anewt = [At 1 0;
         0  1 0;
         0  0 1];
Bnewt = [Bt; 0; 0];
Cnewt = [Ct 0 1; 
          0 1 0; 
          0 0 1];
r = [4; 0.01; 0.01];
%r = zeros(3, 1);
R = diag(r.^2);

q = [1; 0.01; 0.01];
%q = zeros(3, 1);
Q = diag(r.^2);

P = diag([10000 10000 10000]);
XTRUE = [];
XTRUE = [XTRUE, XTruet];
X = [];
X = [X, Xt];

tend = 10;
for i = 1:tend
    XTruet = Anewt*XTruet + Bnewt*ut + [r(1);0;0].*randn(3, 1);
    ZTrue = Cnewt*XTruet + [q(1);0;0].*randn(3, 1);
    
    Xt = Anewt*Xt + Bnewt*ut;
    P = Anewt*P*Anewt' + R;
    K = P*Cnewt'/(Cnewt*P*Cnewt' + Q);
    Xt = Xt + K*(ZTrue - Cnewt*Xt);
    P = (eye(3) - K*Cnewt)*P;
    
    XTRUE = [XTRUE, XTruet];   
    X = [X, Xt];
end

figure(1)
plot(1:tend+1, XTRUE(1,:));
hold on;
plot(1:tend+1, X(1,:));
hold off;
grid;
legend('X_{true}', 'X_{pred}');

figure(2)
plot(1:tend+1, XTRUE(2,:));
hold on;
plot(1:tend+1, X(2,:));
hold off;
grid;
legend('d_{true}', 'd_{pred}');

figure(3)
plot(1:tend+1, XTRUE(3,:));
hold on;
plot(1:tend+1, X(3,:));
hold off;
grid;
legend('e_{true}', 'e_{pred}');