function q = move(p, U)
   
    pExact = 0.8;
    pInExact = 0.2/8;
    
    Ux = U(1);
    Uy = U(2);
    
    % first shift along columns
    % for each row
    q = zeros(size(p));
    if(Ux == size(p, 2) || Ux == -size(p, 2))
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
    q = zeros(size(p));
    if(Uy == size(p, 2) || Uy == -size(p, 2))
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
end