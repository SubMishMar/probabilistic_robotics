Xt_1 = randn(3, 1);
% figure(1);
% plot(Xt_1(1), Xt_1(2), '-bo');
% hold on;
delT = 1;
alphas = [0.01, 0.01, 0.005, 0.005, 1, 1];
Ut = [3, 0.1];
v = Ut(1);
omega = Ut(2);
Ut = [v + sample_normal_distribution(alphas(1)*v^2 + alphas(2)*omega^2);
      omega + sample_normal_distribution(alphas(3)*v^2 + alphas(4)*omega^2)];
which_dist = 0;

plotVar = zeros(length(-6:0.1:6)*...
                length(-6:0.1:6)*...
                length(-pi:0.01:pi), 3);
 i = 1;
for x = -6:0.5:6
    for y = -6:0.5:6
        for theta = -pi:0.01:pi
            Xt = [x, y, theta];
            prob = motion_model_velocity(Xt, Ut, Xt_1, delT,... 
                                        alphas, which_dist);
            plotVar(i,:) = [x,y, prob]; 
            i = i+1;
        end
    end
end

x = plotVar(1:1:end,1);
y = plotVar(1:1:end,2);
z = plotVar(1:1:end,3);

plot3(x, y, z, '.');
axis square;
grid;
xlabel('X');
ylabel('Y');
zlabel('Probability');