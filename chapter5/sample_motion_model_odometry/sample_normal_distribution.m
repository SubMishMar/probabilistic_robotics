function sample = sample_normal_distribution(var)
% sig: standard deviation
    sig = sqrt(var);
    if sig < 0
        sig = abs(sig);
    end
    random_set = -sig +2*sig.*rand(12, 1);
    sample = (1/12)*sum(random_set);
end