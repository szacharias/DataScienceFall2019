function [t , y ] = msah_Final_p1c( N )

% N Number of time steps 
% return 
% time vector t
% solution vector y
% using explicit improved euler method

y0 = 0 ;
t_top = 1;
t_bottom = 0;
h = 0.05;
% n = (t_top - t_bottom) / h ;

% t vector

%for i = 1:1:n+1;
%    t(i) = t_bottom + ( i - 1 ) * h;
%    
%end

t = linspace(0, 1, N )

y(1) = y0;

for i = 1:1:N-1 
    y_star(i) = y(i) + h * msah_Final_p1a(t(i) , y(i));
    y1 =msah_Final_p1a(t(i), y(i));
    y2 =msah_Final_p1a(t(i+1),y_star(i));
    y(i+1) = y(i) + 0.5*h*(y1 + y2);

end
t;
y;

%best results at N = 21 for this question


end

