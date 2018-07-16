function X = move(X, control_ip, control_noise, world_size)

   forward_motion = control_ip(1);
   if (forward_motion < 0)
       disp('Cant move backwards, control input not processed!');
       disp('Exiting move block!');
       return;
   end
   
   angular_motion = control_ip(2); % input is in degrees
   
   forward_motion_noise = control_noise(1);
   angular_motion_noise = control_noise(2);
   
   theta = X(3);
   theta = theta + angular_motion + angular_motion_noise*randn(1,1);
   theta = mod(theta, 2*pi);
   
   forward_motion = forward_motion + forward_motion_noise*randn(1,1);
   
   X(1:2,:) = X(1:2,:) + [cos(theta); sin(theta)]*forward_motion;
   X(1) = mod(X(1), world_size);
   X(2) = mod(X(2), world_size);
   X(3) = theta;
end