clear all
clc;
p = ones(5, 5);
p = p/sum(sum(p));

p = sense(p, [2,3])
p = move(p, [-2,-4])