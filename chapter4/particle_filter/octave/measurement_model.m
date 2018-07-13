function weight = measurement_model(z, x, l)
    % Computes the observation likelihood of all particles.
    %
    % The employed sensor model is range only.
    %
    % z: set of landmark observations. Each observation contains the id of the landmark observed in z(i).id and the measured range in z(i).range.
    % x: set of current particles
    % l: map of the environment composed of all landmarks
    sigma = [0.2];
    weight = ones(size(x, 1), 1);

    if size(z, 2) == 0
        return
    endif
    
    for i = 1:size(z, 2)
        landmark_position = [l(z(i).id).x, l(z(i).id).y];
        measurement_range = [z(i).range];

        % Create matrices matching the size of the particle vector for
        % landmark and observation
        L = repmat(landmark_position, size(x, 1), 1);
        Z = repmat(measurement_range, size(x, 1), 1);
        % Compute difference in distance for all particles at once
        range = L - x(:, 1:2);
        delta_dist = sqrt(sum(range .^ 2, 2));

        % Update all weights at once
        weight = weight .* normpdf(delta_dist  - Z(:,1), 0, sigma(1));
    endfor

    weight = weight ./ size(z, 2);
end
