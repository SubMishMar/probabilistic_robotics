function q = move_inexact(p, U)
   
    pExact = 0.8;
    pUndershoot = 0.1;
    pOvershoot = 0.1;
    
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
        q = pExact*q + ...
            pUndershoot*[q(end), q(1:end-1)] + ...
            pOvershoot*[q(2:end), q(1)];
    end
    q = q/sum(q);
end