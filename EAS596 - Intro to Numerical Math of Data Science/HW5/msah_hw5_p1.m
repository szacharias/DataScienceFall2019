function [L,U] = msah_hw5_p1( A )
%MSAH_HW5_P1 Summary of this function goes here
%   Detailed explanation goes here 

%     A =  [  1.566627550977876   0.473555873456419   0.188825202603897   0.356779404159239   0.362539853002689,
%    0.342227037722746   1.064213790573372   0.240478929791373   0.092906647827715   0.203143457935221,
%    0.329088011290192   0.031027650101346   1.907521211402219   0.569879929422053   0.120704998546467,
%    0.921102816720488   0.498623086778279   0.587205022760642   1.557469485932989   0.829496067391201,
%    0.809847415177181   0.252879674577369   0.764198052884446   0.599343589516687   1.124707946746329 ] 
    %A = [4 3; 6 3] ; % Input matrix which is to be factored 
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
    LU = L * U ;
    difference = A - LU ;
end
