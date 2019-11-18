function [Q,R] = msah_hw5_p3b(A) 

 
object_matrix = A;
[m, n ] = size(object_matrix);

R = zeros(n , n );
Q = zeros(m , n );

for q = 1 : n
    x = object_matrix(:, q);
    for w = 1 : q-1
        
        R(w,q) = Q(:,w)' * x;
        x = x - R(w,q ) * Q(:, w);
        
    end
    
    R( q , q ) = norm(x);
    Q(:, q) = x / R(q ,q);
end
    format short
    Q;
    R;

end
