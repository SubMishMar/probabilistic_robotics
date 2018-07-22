function sample = sample_triangular_distribution(sig)
% sig: standard deviation
    if sig < 0
        sig = abs(sig);
    end
    random_1 = -sig +2*sig.*rand(1, 1);
    random_2 = -sig +2*sig.*rand(1, 1);
    sample = (sqrt(6)/2)*(random_1 + random_2);
end