function Xt = sample_motion_model_odometry(Xt_1, Xbart_1, Xbart, alphas)
    % which_dist: 0 for normal dist sampling 1 for triangular
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    
    xbart_1 = Xbart_1(1);
    ybart_1 = Xbart_1(2);
    Thetabart_1 = atan2(sin(Xbart_1(3)), cos(Xbart_1(3)));
    
    xbart = Xbart(1);
    ybart = Xbart(2);
    Thetabart = atan2(sin(Xbart(3)), cos(Xbart(3)));
    
    delRot1 = atan2(ybart-ybart_1, xbart-xbart_1) - Thetabart_1;
    delTrans = sqrt((xbart-xbart_1)^2 + (ybart-ybart_1)^2);
    delRot2 = Thetabart - Thetabart_1 - delRot1;
    
    var1 = alpha1*delRot1^2 + alpha2*delTrans^2;
    var2 = alpha3*delTrans^2 + alpha4*delRot1^2 + alpha4*delRot2^2;
    var3 = alpha1*delRot2^2 + alpha2*delTrans^2;
    delRot1Cap = delRot1 - sample_normal_distribution(var1);
    delTransCap = delTrans - sample_normal_distribution(var2);
    delRot2Cap = delRot2 - sample_normal_distribution(var3);
    
    x = Xt_1(1);
    y = Xt_1(2);
    theta = Xt_1(3);
    
    x = x + delTransCap*cos(theta + delRot1Cap);
    y = y + delTransCap*sin(theta + delRot1Cap);
    theta = theta + delRot1Cap + delRot1Cap;
    theta = atan2(sin(theta), cos(theta));
    
    Xt = [x;y;theta];
end