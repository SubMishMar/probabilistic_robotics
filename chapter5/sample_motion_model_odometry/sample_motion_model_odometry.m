function [Xt, control] = sample_motion_model_odometry(Xt_1, Xbart_1, Xbart, alphas)
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
    delRot1 = atan2(sin(delRot1), cos(delRot1));
    delTrans = sqrt((xbart-xbart_1)^2 + (ybart-ybart_1)^2);
    delRot2 = Thetabart - Thetabart_1 - delRot1;
    delRot2 = atan2(sin(delRot2), cos(delRot2));
    
    var1 = alpha1*delRot1^2 + alpha2*delTrans^2;
    var2 = alpha3*delTrans^2 + alpha4*delRot1^2 + alpha4*delRot2^2;
    var3 = alpha1*delRot2^2 + alpha2*delTrans^2;
    
    
    delRot1Cap = delRot1 - sample_normal_distribution(var1);
    delRot1Cap = atan2(sin(delRot1Cap), cos(delRot1Cap));  
    
    delTransCap = delTrans - sample_normal_distribution(var2);
    
    delRot2Cap = delRot2 - sample_normal_distribution(var3);
    delRot2Cap = atan2(sin(delRot2Cap), cos(delRot2Cap));
    
%     if delTrans == 0
%         delTransCap = 0;
%     end
%     
%     if delRot1 == 0
%         delRot1Cap = 0;
%     end
%     
%     if delRot2 == 0
%         delRot2Cap = 0;
%     end
    
    x = Xt_1(1);
    y = Xt_1(2);
    theta = Xt_1(3);
    
    x = x + delTransCap*cos(theta + delRot1Cap);
    y = y + delTransCap*sin(theta + delRot2Cap);
    theta = theta + delRot1Cap + delRot2Cap;
    theta = atan2(sin(theta), cos(theta));
    
    Xt = [x, y, theta];
    control = [delRot1Cap, delTransCap, delRot2Cap];
    %control = [delRot1, delTrans, delRot2];
end