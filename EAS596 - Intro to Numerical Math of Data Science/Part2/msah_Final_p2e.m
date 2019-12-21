function [f] = msah_Final_p2e(t, theta1) 


% Calculate fit with coefficients
% return f(x)
corre_ = corrcoef(t, theta1)

theta1
for i = 1:1:length(t)
    f(i) =  ( corre_(2,1) * t(i) / ( t(i) + corre_(1,2)) );
end
f
end

