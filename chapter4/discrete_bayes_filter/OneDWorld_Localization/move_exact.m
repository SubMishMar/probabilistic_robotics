function q = move_exact(p, U)
    
    if(U == length(p) || U == -length(p))
        q = p;
    else
        U = mod(U, length(p));
        for i=1:U
            q = zeros(size(p));
            for j = 1:length(p)
                if(j==1)
                    q(j) = p(end);
                else
                    q(j) = p(j-1);
                end
            end
            p = q;
        end
    end
    q = q/sum(q);
end