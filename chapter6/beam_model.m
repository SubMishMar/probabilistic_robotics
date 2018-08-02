clear all;
close all;
clc;
% pHit
z_max = 50;
zkt_star = 30;
sigma_hit = 2;
z = 0:0.001:z_max;


phit = (1/sqrt(2*pi*sigma_hit^2))...
    *exp(-((z - zkt_star).^2)/(2*sigma_hit^2));
phit = phit/sum(phit);
figure(1);
plot(z,phit);
xlim([0, 75]);
hold on;

%pshort
gamma_short = 0.05;

z = 0:0.001:zkt_star;

pshort = gamma_short*exp(-gamma_short*z);
pshort = pshort/sum(pshort);

plot(z, pshort);
hold on;

z = z_max-0.005:0.001:z_max+0.005;
pmax = ones(1, length(z));
pmax = pmax/sum(pmax);