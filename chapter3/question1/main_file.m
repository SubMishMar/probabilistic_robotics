%%
clear all
clc
%%
X = zeros(2, 1);
P = zeros(2, 2);
X_true = zeros(2, 1);


tend = 5;
std = 1;

r = [0.4; 0.2];
R = diag(r.^2);

q = sqrt(10);
Q = diag(q.^2);

dt = 1;
At = [1 dt;
      0 1];
Bt = [dt^2/2; dt];
Ct = [1 0];


for t = 1:tend
    u = std*randn(1,1); % acc ip with zero mean
                        % and std = 1
    X_true = At*X_true + Bt*u + r.*randn(2, 1);
    
    X = At*X + Bt*u;
    P = At*P*At' + R;
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
    axis([-10 10 -10 10]);
    pause(0.1);
    drawnow;
end

