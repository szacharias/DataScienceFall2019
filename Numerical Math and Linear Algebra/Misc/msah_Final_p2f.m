
L1 = 0.6;
L2 = 0.8;
h = 0.1;

% load time series
load('theta1.mat');

% msah_Final_p2e
% return fitted theta
new_theta = msah_Final_p2e(t, theta1) ;

% use fitted value to rerun previous functions
msah_Final_p2c(t , new_theta ,  L1 , L2 , h );