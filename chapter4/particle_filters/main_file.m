clear all;
close all;
clc;

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
sensor_noise = 5.0; % std/not variance!

%% robot initialization

no_of_iterations = 50;

X_true = zeros(3, no_of_iterations);
x_true = X_true(:,1);
z_true = zeros(size(landmark_locations, 1), no_of_iterations);
control_ip = [1; 0];

%% Generate Truth

for i = 1:no_of_iterations
    z_true(:,i) = sense(x_true, landmark_locations, sensor_noise);
    x_true = move(x_true, control_ip, control_noise, world_size);
    X_true(:,i) = x_true; 
end

%% Particle Filter
% Note that the only thing accecible to the particle filter is
% the measurement z_true and control_ip
% N = 1000; % No of particles
% 
% population = 0:0.001:world_size;
% population_theta = -180:0.001:180;
% 
% X_samples = [randsample(population, N, true); 
%              randsample(population, N, true); 
%              randsample(population_theta, N, true)];
%      
% figure(1);
% for i = 1:no_of_iterations
%     plot(X_samples(1,:), X_samples(2,:),'o',...
%                                 'MarkerSize',5,...
%                                 'MarkerEdgeColor','r',...
%                                 'MarkerFaceColor',[1,0,0]);
%     hold on;
% 
%     plot(landmark_locations(:,1), landmark_locations(:,2),'s',...
%                                 'MarkerSize',25,...
%                                 'MarkerEdgeColor','r',...
%                                 'MarkerFaceColor',[0,1,0])
%     hold off;
%     axis square;
%     xlim([0 100]);
%     ylim([0 100]);
%     grid;
%     prob = zeros(length(X_samples), 1);
%     for j = 1:N
%         predicted_measurement = sense(X_samples(:,j), landmark_locations, 0);
%         
%         prob(j) = measurement_probability(predicted_measurement, ... 
%                                         z_true, sensor_noise);
%         X_samples(:,j) = move(X_samples(:,j), control_ip, zeros(2, 1), world_size);
%     end
%     prob = prob/sum(prob);
%     indexes = randsample(1:N, N,true,prob);
%     X_samples = X_samples(:,indexes);
%     pause(0.1);
% end






