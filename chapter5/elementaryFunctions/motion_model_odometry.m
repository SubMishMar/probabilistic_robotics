function prob = motion_model_odometry(X, Xdash, Xbar, Xdashbar, alphas, which_dist)
    % which_dist = 0 for normal dist and 1 for triangular dist
    
    xbar = Xbar(1); xdashbar = Xdashbar(1);
    ybar = Xbar(2); ydashbar = Xdashbar(2);
    thetabar = Xbar(3); thetadashbar = Xdashbar(3);
    
    delRot1 = atan2(ydashbar - ybar, xdashbar - xbar) - thetabar;
    delTrans = sqrt((xdashbar - xbar)^2 + (ydashbar - ybar)^2);
    delRot2 = thetadashbar - thetabar - delRot1;
    
    x = X(1); xdash = Xdash(1);
    y = X(2); ydash = Xdash(2);
    theta = X(3); thetadash = Xdash(3);
    
    delRot1Cap = atan2(ydash - y, xdash - x) - theta;
    delTransCap = sqrt((xdash - x)^2 + (ydash - y)^2);
    delRot2Cap = thetadash - theta - delRot1;
    
    deltaRot1 = delRot1 - delRot1Cap;
    deltaTrans = delTrans - delTransCap;
    deltaRot2 = delRot2 - delRot2Cap;
    
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    alpha3 = alphas(3);
    alpha4 = alphas(4);
    
    if which_dist == 0
        prob1 = prob_normal_distribution(deltaRot1,...
                         alpha1*abs(delRot1Cap)+alpha2*delTransCap);
        prob2 = prob_normal_distribution(deltaTrans,...
                         alpha3*delTransCap + ...
                         alpha4*(abs(delRot1Cap)+abs(delRot2Cap)));
        prob3 = prob_normal_distribution(deltaRot2,...
                         alpha1*abs(delRot2Cap) + ...
                         alpha2*delTransCap);
        prob = prob1*prob2*prob3;
    elseif which_dist == 1
        prob1 = prob_triangular_distribution(deltaRot1,...
                         alpha1*abs(delRot1Cap)+alpha2*delTransCap);
        prob2 = prob_triangular_distribution(deltaTrans,...
                         alpha3*delTransCap + ...
                         alpha4*(abs(delRot1Cap)+abs(delRot2Cap)));
        prob3 = prob_triangular_distribution(deltaRot2,...
                         alpha1*abs(delRot2Cap) + ...
                         alpha2*delTransCap);
        prob = prob1*prob2*prob3;
    else
        disp('Choose 0 or 1 for which_dist');
        return;
    end
end
