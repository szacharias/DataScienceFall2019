function [L,U] = msah_hw5_p1( A ) 
    [m, n] = size(A);

    % identity matrix
    L = eye(m,min(m,n)) ;
    U = A;  
    
    for q=1:min(m-1, n)
        for w=q+1:m  
            L(w,q) = U(w,q)/U(q,q);
            U(w,q) = 0;
            for k=q+1:n
                U(w,k) = U(w,k) - L(w,q)*U(q,k);
            end
        end
    end 
    
    if m>n 
        U = U(1:n, 1:n);
    end
    
    
    % Verify answer is correct
    %LU = L * U ;
    %difference = A - LU ;
end
