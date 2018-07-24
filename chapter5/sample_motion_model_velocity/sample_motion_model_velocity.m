function Xt = sample_motion_model_velocity(Ut, X_t_1, delT, alphas, which_dist)
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    alpha5 = alphas(5);
    alpha6 = alphas(6);
    
    v = Ut(1);
    omega = Ut(2);
    
    if v == 0 && omega == 0
        x = 0;
        y = 0;
        theta = 0;
    else
        x = X_t_1(1);
        y = X_t_1(2);
        theta = mod(X_t_1(3), 2*pi);

        var1 = alpha1*v^2 + alpha2*omega^2;
        var2 = alpha3*v^2 + alpha4*omega^2;
        var3 = alpha5*v^2 + alpha6*omega^2;

        if which_dist == 0
            vCap = v + sample_normal_distribution(var1);
            omegaCap = omega + sample_normal_distribution(var2);
            gammaCap = sample_normal_distribution(var3);
        else
            vCap = v + sample_triangular_distribution(var1);
            omegaCap = omega + sample_triangular_distribution(var2);
            gammaCap = sample_triangular_distribution(var3);
        end

        rCap = vCap/omegaCap;

        x = x - rCap*sin(theta) + rCap*sin(theta + omegaCap*delT);
        y = y + rCap*cos(theta) - rCap*cos(theta + omegaCap*delT);
        theta = theta + omegaCap*delT + gammaCap*delT;
    end
    Xt = [x; y; theta];
end