function plot_state(particles, weights, landmarks, timestep)
    % Plots the state of the particle filter.
    %
    % Displays the particle cloud, mean position and landmarks.
    %
    % particles: current set of particles
    % weights: current set of particle weights
    % timestep: current step in the filtering process
    clf
    hold on
    grid("on")
    L = struct2cell(landmarks);
    figure(1, "visible", "on");
    plot(particles(:, 1), particles(:, 2), '.');
    plot(cell2mat(L(2,:)), cell2mat(L(3,:)), 'o');
    drawrobot(mean_position(particles, weights), 'r', 3, 0.3, 0.3);
    xlim([-1, 11])
    ylim([-1, 11])
    filename = sprintf('../plots/pf_%03d.png', timestep);
    print(filename, '-dpng');
    hold off
end
