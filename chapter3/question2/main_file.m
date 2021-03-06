%%
clear all
clc
%%
X = zeros(2, 1);
P = 9*ones(2, 2);
X_true = zeros(2, 1);


tend = 20;
std = 1;

r = [1; 1];
R = diag(r.^2);

q = sqrt(10);
Q = diag(q.^2);

dt = 1;
At = [1 dt;
      0 1];
Bt = [dt^2/2; dt];
Ct = [1 0];

px1x1 = [];
px2x2 = [];
px1x1 = [px1x1, P(1, 1)];
px2x2 = [px2x2, P(2, 2)];
for t = 1:tend
    u = std*randn(1,1); % acc ip with zero mean
                        % and std = 1
    X_true = At*X_true + Bt*u + r.*randn(2, 1);
    
    X = At*X + Bt*u;
    P = At*P*At' + R;
    if(mod(t, 5) == 0)
        Kt = P*Ct'/(Ct*P*Ct' + Q);
        z = Ct*X_true + q.*randn(1, 1);
        X = X + Kt*(z - Ct*X);
        P = (eye(2) - Kt*Ct)*P;
    end
    [Xdraw, Ydraw] = covarianceEllipse(X, P, 1, 50);
    figure(1)
    plot(Xdraw, Ydraw);
    hold on;
    plot(X(1), X(2), '+');
    hold on;
    plot(X_true(1), X_true(2), '*');
    hold off;
    grid;
    axis square;
    axis([-150 150 -150 150]);
    pause(0.1);
    drawnow;

    px1x1 = [px1x1, P(1, 1)];
    px2x2 = [px2x2, P(2, 2)];
end
figure(2)
plot(1:length(px1x1), px1x1);
hold on;
plot(1:length(px2x2), px2x2);
hold off;
grid;
legend('px1x1','px2x2');
