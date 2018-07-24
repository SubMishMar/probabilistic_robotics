function sample = sample_triangular_distribution(var)
% var: Variance
    sig = sqrt(var);
    random_1 = -sig +2*sig.*rand(1, 1);
    random_2 = -sig +2*sig.*rand(1, 1);
    sample = (sqrt(6)/2)*(random_1 + random_2);
end