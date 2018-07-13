function avg_angle = average_angle(angles)
    % Computes the average angle of a vector of angles.
    %
    % angles: row vector of angles in radians
    % avg_angle: average angle in radians

    angles = exp(i * angles);
    tmp = mean(angles);
    avg_angle = atan2(imag(tmp), real(tmp));
end
