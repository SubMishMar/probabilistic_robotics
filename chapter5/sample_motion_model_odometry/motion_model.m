function Xt = motion_model(Xt_1, U, alphas)
    v= U(1);
    omega = U(2);
    delT = 0.1;
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    alpha5 = alphas(5);
    alpha6 = alphas(6);
    
    vCap = v + sample_normal_distribution(alpha1*v^2 + alpha2*omega^2);
    omegaCap = omega +...
        sample_normal_distribution(alpha3*v^2 + alpha4*omega^2);
    gammaCap = sample_normal_distribution(alpha5*v^2 + alpha6*omega^2);
    
    xt_1 = Xt_1(1);
    yt_1 = Xt_1(2);
    thetat_1 = atan2(sin(Xt_1(3)), cos(Xt_1(3)));
    
    xt = xt_1 - sin(thetat_1)*vCap/omegaCap + ...
        + sin(thetat_1 + omegaCap*delT)*vCap/omegaCap;
    yt = yt_1 + cos(thetat_1)*vCap/omegaCap + ...
        - cos(thetat_1 + omegaCap*delT)*vCap/omegaCap;
    thetat = thetat_1 + omegaCap*delT + gammaCap*delT;
    Xt = [xt; yt; thetat];
end