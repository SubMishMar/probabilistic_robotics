function Xt = sample_motion_model_velocity(Ut, X_t_1, delT, alphas, which_dist)
    v = Ut(1);
    omega = Ut(2);
    
    x = X_t_1(1);
    y = X_t_1(2);
    theta = X_t_1(3);
    
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    alpha5 = alphas(5);
    alpha6 = alphas(6);
    
    if which_dist == 0
        vCap = v + sample_normal_distribution(alpha1*v^2 + alpha2*omega^2);
        omegaCap = omega + sample_normal_distribution(alpha3*v^2 + alpha4*omega^2);
        gammaCap = sample_normal_distribution(alpha5*v^2 + alpha6*omega^2);
    elseif which_dist == 1
        vCap = v + sample_triangular_distribution(alpha1*v^2 + alpha2*omega^2);
        omegaCap = omega + sample_triangular_distribution(alpha3*v^2 + alpha4*omega^2);
        gammaCap = sample_triangular_distribution(alpha5*v^2 + alpha6*omega^2);
    else
        disp('Choose the correct dist');
    end

    
    xdash = x - sin(theta)*vCap/omegaCap + ...
                sin(theta + omegaCap*delT)*vCap/omegaCap;
    ydash = y + cos(theta)*vCap/omegaCap - ...
                cos(theta + omegaCap*delT)*vCap/omegaCap;
    thetadash = theta + omegaCap*delT + gammaCap*delT;
    
    Xt = [xdash; ydash; thetadash];
end