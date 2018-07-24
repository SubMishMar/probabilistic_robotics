
X = [0.0, 0.0, pi/4];
Ut = [pi/100, 0.0, 1.0];

alphas = [0.1 0.1 0.01 0.01];
no_of_iterations = 500;

which_dist = 0;
figure(1);
for i=1:no_of_iterations
    X = sample_motion_model_odometry(X, Ut, alphas, which_dist);
    plot(X(1), X(2), '-o');
    xlim([-100 100]);
    ylim([-100 100]);
    grid;
    pause(0.1);
end

