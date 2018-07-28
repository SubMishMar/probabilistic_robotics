run generate_odometry.m;
x = zeros(1, 3);
alphas = [1;1;1;1];
for i = 2:length(odometry)
    figure(1);
    plot(x(1), x(2), '-r.');
    hold on;
    t_1 = i-1;
    t = i;
    xbart_1 = odometry(t_1,:);
    plot(xbart_1(1), xbart_1(2), '-g.');
    xbart = odometry(t,:);
    x = sample_motion_model_odometry(x,...
        xbart_1, xbart, alphas);
    
    axis square;
    xlim([-7 7])
    ylim([-7 7]);
    grid;
    hold on;
    drawnow;
end
grid;
hold off;