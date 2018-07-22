function prob = prob_normal_distribution(x, sigma)
    % sigma: standard deviation
    prob = exp(-(x^2)/(2*sigma^2))/sqrt(2*pi*sigma^2);
end