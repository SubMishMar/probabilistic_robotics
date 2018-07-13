function x_new = sample_motion_model(u, x)
    % Samples new particle positions, based on old positions and odometry.
    %
    % u: odometry reading
    % x: set of old particles

    % Noise parameters
    noise = [0.1 0.1 0.05 0.05];

    % Particle count
    pc = size(x, 1);

    % Compute normal distributed noise
    O = repmat([u.r1, u.t, u.r2], pc, 1);
    M = zeros(pc, 3);
    S = repmat([
        max(0.00001, noise(1) * abs(u.r1) + noise(2) * u.t) \
        max(0.00001, noise(3) * u.t  + noise(4) * (abs(u.r1) + abs(u.r2))) \
        max(0.00001, noise(1) * abs(u.r2) + noise(2) * u.t)
    ], pc, 1);
    N = normrnd(M, S, pc, 3);

    % Add noise to the motion for every particle
    odom = O + N;

    % Compute new particle positions
    x_new = x + [
        odom(:, 2) .* cos(x(:, 3) + odom(:, 1)), \
        odom(:, 2) .* sin(x(:, 3) + odom(:, 1)), \
        odom(:, 1) + odom(:, 3)
    ];
end
