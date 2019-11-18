function [L, U] = myLU(A)
%MYLU Summary of this function goes here
%   Detailed explanation goes here

    [m, n] = size(A);

    L = eye(m,min(m,n));
    U = A;
    
    for i=1:min(m-1, n)
        for j=i+1:m  
            L(j,i) = U(j,i)/U(i,i);
            U(j,i) = 0;
            for k=i+1:n
                U(j,k) = U(j,k) - L(j,i)*U(i,k);
            end
        end
    end
    
    if m>n 
        U = U(1:n, 1:n);
    end
    
end

