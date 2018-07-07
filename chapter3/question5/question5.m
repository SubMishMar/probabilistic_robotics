clear all;
clc;
At = 1;
Bt = 1;
ut = 1;

Ct = 1;

d = -10;
e = 2;

Xtrue = 0;
Ztrue = 0;

X = zeros(3, 1);
P = diag([10000 10000 10000]);
for i = 1:1000
    Xtrue = At*Xtrue + Bt*ut + d + sqrt(1)*randn(1,1);
    Ztrue = Ct*Xtrue + e + sqrt(1)*randn(1,1);
    
    Anewt = [At 1 0;
             0  1 0;
             0  0 1];
         
    X = Anewt*X + [Bt;0;0]*ut;
    Cnewt = [Ct 0 1];
    R = diag([100 100 100]);
    P = Anewt*P*Anewt' + R;
    Q = diag([1]);
    K = P*Cnewt'/(Cnewt*P*Cnewt' + Q);
    X = X + K*(Ztrue - (Cnewt*X+e));
    P = (eye(3) - K*Cnewt)*P;
end