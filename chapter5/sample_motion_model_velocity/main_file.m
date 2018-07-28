Xt_1 = [0, 0, 0];
figure(1);
plot(Xt_1(1), Xt_1(2), '-bo');
hold on;
delT = 1;
alphas = [0.1, 0.1, 0.05, 0.05, 1, 1];
ut = [10, pi/4];
which_dist = 0;

no_of_iterations = 5000;
Xt = [];
for i = 1:no_of_iterations
    Xt = [Xt; sample_motion_model_velocity(ut, Xt_1, delT, alphas, which_dist)'];
end
figure(1);
plot3(Xt(:, 1), Xt(:, 2),...
    zeros(length(Xt), 1), '.r');
xlim([-15, 15]);
ylim([-15, 15]);
axis square;
grid;
hold off;
xlabel('X');
ylabel('Y');
