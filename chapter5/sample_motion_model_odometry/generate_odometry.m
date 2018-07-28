close all;
clc;
clear;

X = zeros(3,1);
alphas = [1;1;1;1;1;1];

U = [0.5; pi/20];
% figure(1);

odometry = [];
for i = 1:300
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