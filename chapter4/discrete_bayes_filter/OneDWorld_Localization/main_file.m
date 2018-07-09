clear;
clc;

world = ["green", "red", "red", "green", "green"];
p = [0.2, 0.2, 0.2, 0.2, 0.2]; % initial belief
measurements = ["red", "red"];
motions = [1, 1];

figure(1);
bar(p);
pause(1)
for i = 1:length(measurements)
    p = sense(p, measurements(i), world);
    p = move_inexact(p, motions(i));
    bar(p)
    pause(1);
end


