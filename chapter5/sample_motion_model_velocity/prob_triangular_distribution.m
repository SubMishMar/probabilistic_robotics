function prob = prob_triangular_distribution(x, sigma)
    % sigma: standard deviation
    if sigma < 0
        disp('Received -ve sigma, changing sign');
        sigma = abs(sigma);
    end
    prob_max = 1/(sqrt(6)*sigma) - abs(x)/(6*sigma^2);
    prob = max([0, prob_max]);
end