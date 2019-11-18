
% clear workspace
clc
clear
format long

alpha = 1/2;
x = 2.;

y = x^alpha;

x
y


n = 64;
x = (1:n)';
x = 2*x/n;
b = 4.;
x

for j=1:4
    alpha = j/2;
    % for i=1:n
    %     y(i) = x(i)^alpha + b;
    % end
    [y] = power_law(n,alpha,x);
    j
    alpha
    y'
end

figure(1)
plot(x,y)

figure(2)
loglog(x,y)


