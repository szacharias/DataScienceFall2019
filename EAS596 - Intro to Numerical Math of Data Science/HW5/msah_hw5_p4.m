


bot_range = 2;
top_range = 10;
difference = top_range - bot_range + 2;

% init
matrix_size = zeros(difference);
p3a_lst = zeros(difference);
p3b_lst = zeros(difference);
og_lst = zeros(difference);


for i=  bot_range:top_range
    
    H = hilb(i);
    
    % USE 3a
    [aQ, aR] = msah_hw5_p3a(H);
    
    % USE 3b
    [bQ, bR] = msah_hw5_p3b(H);
    
    % USE QR
    [ogQ, ogR] = qr(H);
     
    % Plot kQ T Q − Ik versus matrix size on a semilogy plot for
    % each method and comment on your results.
    matrix_size(i) = i ;
    p3a_lst(i) = semi_value(aQ);
    p3b_lst(i) = semi_value(bQ);
    og_lst(i) = semi_value(ogQ);
    
end

produce_graphs(p3a_lst, p3b_lst ,og_lst, matrix_size)

function [ semi_value ] = semi_value (Q)
    [m, n ] = size(Q);
    I = eye( m , n );
    not_normed_result = Q * Q.' - I;
    semi_value = norm(not_normed_result) ;%/ norm(not_normed_result)
end


function produce_graphs(p3a_lst, p3b_lst ,og_lst, matrix_size)

semilogy(  p3a_lst );
hold on
semilogy( p3b_lst) ;
semilogy(og_lst ) ;
title("||Q transpose Q - I || versus matrix size ")
xlabel(' Matrix Size');
ylabel(' norm of Q transpose * Q - I'); 
legend('p3a_lst' , 'p3b_lst' , 'og_lst')

hold off

end

