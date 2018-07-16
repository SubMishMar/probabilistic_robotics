clear all;
close all;
clc;

disp('Basic Implementation of Particle Filter for Robot Localization');
disp('The filter may not always converge to the correct solution')
disp('So try changing the no of particles[preferably increasing it]');
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

no_of_iterations = 500;
delP = 1;
delOmega = 5*pi/180;
control_ip = [delP; delOmega];


%% Particle Filter
% Note that the only thing accecible to the particle filter is
% the measurement z_true and control_ip
N = 10000; % No of particles

population = 0:0.001:world_size;
population_theta = 0:0.001:360;

X_samples = [randsample(population, N, true); 
             randsample(population, N, true); 
             randsample(population_theta, N, true)];
         
% Can Randomly set the initial point or choose fixed values
x_true = [randsample(population, 1, true);
          randsample(population, 1, true); 
          randsample(population_theta, 1, true)];
% x_true = zeros(3, 1);
% x_true = [50;50;0];
figure(1);   
for i = 1:no_of_iterations
    if i==1
        disp('Paused for 2 seconds..');
        plot_file(landmark_locations, x_true, X_samples, 2);
        disp('Running...');
    else
        plot_file(landmark_locations, x_true, X_samples, 0.1);
    end
    x_true = move(x_true, control_ip, control_noise, world_size);
    z_true = sense(x_true, landmark_locations, sensor_noise);
    prob = zeros(1, N);
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
end
disp('Exited');





