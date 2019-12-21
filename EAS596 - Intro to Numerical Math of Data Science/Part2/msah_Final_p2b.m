function [x, theta2]= msah_Final_p2b(theta1, L1, L2, h)

%1
% vector theta1 and scalars L1 , L2, and h ,
% and returns the values x 
% and theta2 for each value in theta1.

% s2
% You must use a nonlinear Newton solver that you have written
% yourself to solve for eachxandtheta2
% theta2 = sin^-1 ( h- L1 * sin(theta) / L2 ) 
% x = L1 * cos(theta1) + L2 * cos(theta2)

for i = 1:1:length(theta1)   
    [x(i), theta2(i) ]= newton_solve(theta1(i), L1, L2, h); 
    %x(i) = x_temp;
    %   theta2(i) = theta_temp ;
    %[x(i), theta2(i) ] 
end

%x;
%theta2;

end

function [x, theta2_indi] = newton_solve(theta1, L1, L2, h)

theta2_indi = asin((h - L1 * sin(theta1)) / L2);
x = L1 * cos(theta1) + L2 * cos(theta2_indi);

end