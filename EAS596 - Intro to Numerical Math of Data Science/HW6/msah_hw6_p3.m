function [ B ] = msah_hw6_p3(A, p)

base_matrix = A;
rank_target = p;

[m , n , c ] = size(base_matrix);

rank(base_matrix)

if rank_target > rank(base_matrix)
    B = base_matrix;
else


[u , s , v ] = svd(base_matrix);

S = s;

S(rank_target+1 : m , :) = 0;
S(:, rank_target+1 : n) = 0;

V = v';

output_matrix = u(:, 1:rank_target) * S(1:rank_target , 1: rank_target) * V(1:rank_target , :)
% is the rank-k approximation of A
norm(base_matrix - output_matrix);
    
end

end

