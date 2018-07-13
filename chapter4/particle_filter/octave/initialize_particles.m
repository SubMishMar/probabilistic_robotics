function particles = initialize_particles(count)
    % Returns a set of randomly initialized particles.
    particles = [
        normrnd(0.0, 1, count, 1), \
        normrnd(0.0, 1, count, 1), \
        unifrnd(-pi, pi, count, 1)
    ];
end

