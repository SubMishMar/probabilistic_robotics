function dist = sense(Xr, landmark_locations, sensor_noise)
    x_r = Xr(1); 
    y_r = Xr(2);
    dist = zeros(length(landmark_locations), 1);
    for i=1:size(landmark_locations, 1)
        dist(i) = sqrt((x_r - landmark_locations(i,1))^2 + ...
                       (y_r - landmark_locations(i,2))^2) + ...
                       sensor_noise*randn(1,1); 
    end
end