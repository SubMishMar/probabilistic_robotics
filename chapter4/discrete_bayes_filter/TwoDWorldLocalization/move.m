function q = move(p, U)
   
    pExact = 0.8;
    pOvershootx = 0.2/4;
    pUndershootx = 0.2/4;
    pOvershooty = 0.2/4;
    pUndershooty = 0.2/4;   
    
    Ux = U(1);
    Uy = U(2);
    
    % first shift along columns
    % for each row
    if(Ux == size(p, 2) || Ux == -size(p, 2) || Ux == 0)
        q = p;
    else
        Ux = mod(Ux, size(p, 2));
        for i = 1:Ux
            q = zeros(size(p));
            for j = 1:size(p, 2)
                if(j == 1)
                    q(:,j) = p(:, end);
                else
                    q(:,j) = p(:, j-1);
                end
            end
            p = q;
        end
    end
    p = q';
    if(Uy == size(p, 2) || Uy == -size(p, 2) || Uy == 0)
        q = p;
    else
        Uy = mod(Uy, size(p, 2));
        for i = 1:Uy
            q = zeros(size(p));
            for j = 1:size(p, 2)
                if(j == 1)
                    q(:,j) = p(:, end);
                else
                    q(:,j) = p(:, j-1);
                end
            end
            p = q;
        end
    end
    q = q';
    q = pExact*q + ...
        pOvershootx*[q(:,end), q(:,1:end-1)] + ...
        pUndershootx*[q(:,2:end), q(:,1)] + ...
        pOvershooty*[q(end,:);q(1:end-1,:)] + ...
        pUndershooty*[q(2:end,:);q(1,:)];
end