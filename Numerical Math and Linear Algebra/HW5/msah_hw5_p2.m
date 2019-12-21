format long 

matrix_sizes = 50;

start_range_10s = 1;

% replace this with 3
end_range_10s = 3;
 

% replace this with  
y = ceil(logspace(start_range_10s,end_range_10s, matrix_sizes) );


%loglog(y)
 
time_elapsed_lst = zeros(1,matrix_sizes);
reletive_n_size = zeros(1,matrix_sizes);


for i = 1:length(y)  
    n = y(i);
    A = rand(n,n)+n*eye(n);
    tic;
    msah_hw5_p1(A);  
    time_elapsed_lst(i) = toc;
    reletive_n_size(i)= n;
end
 
% Loglog plots
loglog( reletive_n_size , time_elapsed_lst);
hold on ;
xlabel('Logspace N Size');
ylabel(' Time Cost'); 
p = polyfit(reletive_n_size,time_elapsed_lst,1);
y1 = polyval(p,reletive_n_size); 
plot(reletive_n_size,y1);
hold off