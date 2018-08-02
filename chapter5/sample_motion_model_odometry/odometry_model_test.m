run generate_odometry.m;


alphas = [1;1;1;1];
xPred = [];
control = [];

N = 1; % no of particles
x  = zeros(3, N);

% x = zeros(1, 3);
% controls = [];
for i = 2:length(odometry)
%     disp(i);
%     xPred = [xPred;x];

    t_1 = i-1;
    t = i;
    xbart_1 = odometry(t_1,:);
    xbart = odometry(t,:); % this is the measurment
                           % also used as control ip
%     [x, control] = sample_motion_model_odometry(x, xbart_1,...
%                         xbart, alphas);
%     controls = [controls; control];
    for j = 1:N
        [x(:,j), ~] = sample_motion_model_odometry(x(:,j),...
            xbart_1, xbart, alphas);
    end
    figure(1);
    plot(odometry(:,1), odometry(:,2));
    hold on;
    plot(x(1,:), x(2,:), 'r.')
    hold on;
    plot(xbart(1), xbart(2), '-d','MarkerSize',5,...
    'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[0 1 0]);
    hold off;
    grid;
    axis square;
    axis equal;
    drawnow;

end

% xPred = [xPred;x];
% 
% thetaOdometry = diff(odometry(:,3));
% 
% figure(1);
% plot(xPred(:,1), xPred(:,2));
% hold on;
% plot(odometry(:,1), odometry(:,2));
% hold off;
% grid;
% legend('Prediction', 'Odometry');
% 
% thetaPred = diff(xPred(:,3)*180/pi);
% thetaOdom = diff(odometry(:,3)*180/pi);
% 
% thetas = [thetaOdom, thetaPred];