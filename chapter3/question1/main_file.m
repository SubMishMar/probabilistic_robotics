%% Clear Stuff
clear;
clc;

%% Initialize

X = zeros(2, 1);
Xtrue =  X;
u = zeros(1, 1);
P = zeros(2, 2);
std = 1; % standard deviation of ip
mu = 0; % mean of ip
for t = 1:5
    [X, P] = motion_model(X, mu, P);
    [Xtrue, ~] = motion_model(Xtrue,... 
                              std*randn(1,1)+ mu, P);
end