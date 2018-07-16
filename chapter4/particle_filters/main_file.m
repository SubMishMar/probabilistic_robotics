clear all;
close all;
clc;

disp('Basic Implementation of Particle Filter for Robot Localization');
disp('The filter does not always converge to the correct solution')
disp('So re run the code if it doesnt converge to the truth');
%% world parameters 

world_size = 100;
landmark_locations = [20, 20; % A
                      20, 80; % B
                      80, 80; % C
                      80, 20];% D

%% robot parameters

forward_motion_noise = 0.05; % std/not variance!
turn_motion_noise = 0.05; % std/not variance!

control_noise = [forward_motion_noise;
                  turn_motion_noise];
sensor_noise = 10.0; % std/not variance!

%% robot initialization

no_of_iterations = 1000;
delP = 1;
delOmega = 0*pi/180;
control_ip = [delP; delOmega];


%% Particle Filter
% Note that the only thing accecible to the particle filter is
% the measurement z_true and control_ip
N = 1000; % No of particles

population = 0:0.001:world_size;
population_theta = 0:0.001:360;

X_samples = [randsample(population, N, true); 
             randsample(population, N, true); 
             randsample(population_theta, N, true)];

x_true = [randsample(population, 1, true);
          randsample(population, 1, true); 
          randsample(population_theta, 1, true)];

figure(1);
for i = 1:no_of_iterations
    x_true = move(x_true, control_ip, control_noise, world_size);
    z_true = sense(x_true, landmark_locations, sensor_noise);
    for j = 1:N
        
        X_samples(:,j) = move(X_samples(:,j), control_ip, control_noise, world_size);
        predicted_measurement = sense(X_samples(:,j), landmark_locations, 0); 
        prob(j) = measurement_probability(predicted_measurement, z_true, sensor_noise);
    
    end
    
    prob = prob/sum(prob);
    index = randsample(1:N, 1);
    
    % Resampling procedure
    beta = 0.0;
    X_samples_temp = zeros(size(X_samples));
    probMax = max(prob);
    
    for j = 1:N
        
        beta = beta + 2*probMax*rand(1, 1);

        while(beta > prob(index))
            beta = beta - prob(index);
            index = index+1;
            if (index > N)
                index = index - N;
            end
        end
        X_samples_temp(:,j) = X_samples(:, index);
        
    end
    
    X_samples = X_samples_temp;
    
    measurement_lineAx = linspace(landmark_locations(1,1), x_true(1), 100);
    measurement_lineAy = linspace(landmark_locations(1,2), x_true(2), 100);
    measurement_lineBx = linspace(landmark_locations(2,1), x_true(1), 100);
    measurement_lineBy = linspace(landmark_locations(2,2), x_true(2), 100);
    measurement_lineCx = linspace(landmark_locations(3,1), x_true(1), 100);
    measurement_lineCy = linspace(landmark_locations(3,2), x_true(2), 100);
    measurement_lineDx = linspace(landmark_locations(4,1), x_true(1), 100);
    measurement_lineDy = linspace(landmark_locations(4,2), x_true(2), 100);
    plot(measurement_lineAx, measurement_lineAy, '--r');
    hold on;
    plot(measurement_lineBx, measurement_lineBy, '--r');
    hold on;
    plot(measurement_lineCx, measurement_lineCy, '--r');
    hold on;
    plot(measurement_lineDx, measurement_lineDy, '--r');
    hold on;
    plot(landmark_locations(:,1), landmark_locations(:,2),'s',...
                                'MarkerSize',25,...
                                'MarkerEdgeColor','r',...
                                'MarkerFaceColor',[0,1,0])
    hold on;
    plot(X_samples(1,:), X_samples(2,:),'o',...
                                'MarkerSize',1,...
                                'MarkerEdgeColor','b',...
                                'MarkerFaceColor',[0,0,1])
    hold on;
    plot(x_true(1), x_true(2),'o',...
                                'MarkerSize',5,...
                                'MarkerEdgeColor','r',...
                                'MarkerFaceColor',[1,0,0]);
    hold off;
    prob = zeros(1, N);
    axis square;
    xlim([0 100]);
    ylim([0 100]);
    grid;
    pause(0.1);   
end






