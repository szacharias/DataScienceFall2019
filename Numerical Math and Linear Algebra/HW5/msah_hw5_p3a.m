function [Q,R] = msah_hw5_p3a(A) 
format short

object_matrix = A;
[m, n ] = size(object_matrix);

R = zeros(n , n );
Q = zeros(m , n );


for q = 1:n
   x = object_matrix(:, q);
   for w = 1 : q - 1
       R(w, q) = Q(: , w)' * x;
   end
   
   for w = 1 : q - 1
        x = x- R( w , q ) * Q(:,w );
   end
   
   R(q, q) = norm(x);
   
   Q(:,q) = x / R(q , q );
   
end
 
   Q;
   R;

end


% A = [
%     1 2 3 ,
%     4 5 6 ,
%     7 8 9 ,
%     4 3 2 ,
%     4 2 2 
% 
% ]

