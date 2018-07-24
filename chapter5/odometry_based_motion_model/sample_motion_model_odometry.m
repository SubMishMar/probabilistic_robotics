function Xdash = sample_motion_model_odometry(X, Ut, alphas, which_dist)
    % which_dist: 0 for normal dist sampling 1 for triangular
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    
    x = X(1);
    y = X(2);
    theta = mod(X(3), 2*pi);
    
    delRot1 = Ut(1);
    delRot2 = Ut(2);
    delTrans = Ut(3);
    
    if which_dist == 0 
        delRot1Cap = delRot1 -...
            sample_normal_distribution(alpha1*delRot1^2 + ...
            alpha2*delTrans^2);
        delTransCap = delTrans -...
            sample_normal_distribution(alpha3*delTrans^2 + ...
            alpha4*(delRot1^2 + delRot2^2));
        delRot2Cap = delRot2 -...
            sample_normal_distribution(alpha1*delRot2^2 + ...
            alpha2*delTrans^2);
    elseif which_dist == 1
        delRot1Cap = delRot1 -...
            sample_triangular_distribution(alpha1*delRot1^2 + ...
            alpha2*delTrans^2);
        delTransCap = delTrans -...
            sample_triangular_distribution(alpha3*delTrans^2 + ...
            alpha4*(delRot1^2 + delRot2^2));
        delRot2Cap = delRot2 -...
            sample_triangular_distribution(alpha1*delRot2^2 + ...
            alpha2*delTrans^2);
    else
        disp('Wrong choice of dist');
        return;
    end
    
    xdash = x + delTransCap*cos(theta + delRot1Cap);
    ydash = y + delTransCap*sin(theta + delRot1Cap);
    thetadash = theta + delRot1Cap + delRot2Cap;
    
    Xdash = [xdash; ydash; thetadash];
end