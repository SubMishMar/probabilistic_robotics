function q = sense(p, Z, world)

    pHit = 0.6;
    pMiss = 0.2;
    
    assert(length(p)==length(world));
    q = zeros(size(p));
    for i=1:length(world)
        hit = (Z == world(i));
        q(i) = (hit*pHit + (1-hit)*pMiss)*p(i);
    end
    q = q/sum(q);
    
end