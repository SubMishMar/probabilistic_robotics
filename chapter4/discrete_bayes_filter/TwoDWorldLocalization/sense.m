function p = sense(p, Z)
    
    pHit = 0.6;
    pMeasure = 0.2;
    
    for i = 1:size(p, 1)
        for j = 1:size(p, 2)
            if(Z(1) == i && Z(2) == j)
                p(i, j) = pHit*p(i, j);
            else
                p(i, j) = pMeasure*p(i, j);
            end
        end
    end
    
    p = p/sum(sum(p));
end