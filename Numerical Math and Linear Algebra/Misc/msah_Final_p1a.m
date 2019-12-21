function [ yp ] = msah_Final_p1a( t, y ) 

%%yp = y * (-2 * t + 1 / t);
yp = exp(-t^2) - 2 * t ^ 2 * exp( -t ^ 2 );

end

