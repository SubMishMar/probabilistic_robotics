function prob = motion_model_velocity(Xt, Ut, Xt_1, delT, alphas, which_dist)
    % which_dist: 0 for normal
    %             1 for triangular    
    xdash = Xt(1);
    ydash = Xt(2);
    theta_dash = mod(Xt(3), 2*pi);

    x = Xt_1(1); 
    y = Xt_1(2);
    theta = mod(Xt_1(3), 2*pi);
    
    v = Ut(1);
    omega = Ut(2);
    
    mu = 0.5 * ((x - xdash)*cos(theta) + (y - ydash)*sin(theta))...
        /((y - ydash)*cos(theta) - (x - xdash)*sin(theta));
    
    xstar = (x + xdash)/2 + mu*(y - ydash);
    ystar = (y + ydash)/2 + mu*(xdash - x);
    
    rstar = sqrt((x - xstar)^2 + (y - ystar)^2);
    
    delTheta = atan2(ydash - ystar, xdash - xstar) ...
        - atan2(y - ystar, x - xstar);
    
    vCap = (delTheta/delT)*rstar;
    omegaCap = (delTheta/delT);
    gammaCap = (theta_dash - theta)/delT - omegaCap;
    
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    alpha5 = alphas(5);
    alpha6 = alphas(6);
    
    delv = v - vCap;
    delOmega = omega - omegaCap;
    
    if which_dist == 0
        prob1 = prob_normal_distribution(delv,...
                        alpha1*v^2 + alpha2*omega^2);
        prob2 = prob_normal_distribution(delOmega,...
                        alpha3*v^2 + alpha4*omega^2);
        prob3 = prob_normal_distribution(gammaCap,...
                        alpha5*v^2 + alpha6*omega^2);
        prob = prob1 * prob2 * prob3;
    elseif which_dist == 1
        prob1 = prob_triangular_distribution(delv,...
                        alpha1*v^2 + alpha2*omega^2);
        prob2 = prob_triangular_distribution(delOmega,...
                        alpha3*v^2 + alpha4*omega^2);
        prob3 = prob_triangular_distribution(gammaCap,...
                        alpha5*v^2 + alpha6*omega^2);
        prob = prob1 * prob2 * prob3;
    else
        disp('Choose 0 or 1 for which_dist');
        return;
    end
    
end