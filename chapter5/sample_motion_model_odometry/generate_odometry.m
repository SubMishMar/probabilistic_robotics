close all;
clc;
clear;

X = zeros(3,1);
alphas = [1;1;1;1;1;1];


% figure(1);

odometry = [];
% U = [1, pi/10];
n = 10000;
for i = 1:n
    if i < n/4
        U = [1, 0];
    elseif i == n/4
        U = [0, 50*pi];
    elseif i > n/4 && i < 2*n/4
        U = [1, 0];
    elseif i == 2*n/4
        U = [0, 50*pi];
    elseif i > 2*n/4 && i < 3*n/4
        U = [1, 0];
    elseif i == 3*n/4
        U = [0, 50*pi];
    else
        U = [1, 0];
    end
    odometry = [odometry; X'];
    X = motion_model(X, U, alphas);
%     figure(1);
%     plot(X(1), X(2), '-r.');
%     axis square;
%     xlim([-6 6])
%     ylim([-6 6]);
%     grid;
%     hold on;
%     %pause(0.1);
%     drawnow;
end
% grid;
% hold off;
clear alphas;
clear i
clear U;
clear X;


