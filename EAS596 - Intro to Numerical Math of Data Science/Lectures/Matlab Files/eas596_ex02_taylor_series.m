
% clear workspace
clc
clear
format long

a = 0;
x = 2;
N = 20;
eps = 1e-6;

expx = exp(x);
% expx

fts = 0;

for n=0:N
    
    fts = fts + exp(a)*(x-a)^n/factorial(n);
    err = fts - expx;
    
    if abs(err) < eps
    
        % convergence
        n
        expx
        fts
        err
        break
        
    end
end



