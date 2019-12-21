
% clear workspace
clc
clear

format long

% create a stiff matrix A from eigenvalues and eigenvectors
theta = pi/6;
Phi = [ cos(theta) -sin(theta); sin(theta) cos(theta) ]
Lambda = [ 200 0; 0 1 ]

A = Phi*Lambda*Phi'

% check eigenvalues and eigenvectors of A
[ PhiA, LambdaA ] = eig(A)

% set initial conditions
y0 = [ 1; -1 ]

% find coefficients satisfying initial conditions
c = A\y0

% set final time tf
tf = 5

% set time step information for explicit Euler
dt = 0.005    % dt smaller than critical value
% dt = 0.0105    % dt larger than critical value
n = tf/dt

% set time step information for implicit Euler
dti = 0.05
ni = tf/dti

% initialize dependent variables at time zero
yexp = y0
yimp = y0

% run time step loop for explicit Euler method
for i=1:n
   
   % store current time for plotting
   t(i) = i*dt;
   
   % evaluate new values of dependent variables
   yexp = (eye(2)-dt*A)*yexp;
   
   % store dependent variables for plotting
   y1(i) = yexp(1);
   y2(i) = yexp(2);
   
end

% run time step loop for implicit Euler method
for i=1:ni
   
   % store current time for plotting
   ti(i) = i*dti;
   
   % solve for new values of dependent variables (naive approach)
   yimp = inv(eye(2)+dti*A)*yimp;
   
   % store dependent variables for plotting
   y1i(i) = yimp(1);
   y2i(i) = yimp(2);
   
end

% plot results from explicit and implicit Euler methods
figure(1)
plot(t,y1,'k-',t,y2,'r:',ti,y1i,'b-.',ti,y2i,'m--',...
     'LineWidth',1.5,'MarkerSize',8)
title({'\fontsize{14} Stiff ODEs';...
       '\fontsize{12} Explicit and Implicit Euler Methods'})
xlabel('\fontsize{14} t')
ylabel('\fontsize{14} y','FontWeight','bold')
legend('\fontsize{11} y_1(t) Explicit',...
       '\fontsize{11} y_2(t) Explicit',...
       '\fontsize{11} y_1(t) Implicit',...
       '\fontsize{11} y_2(t) Implicit',...
       'Location','Northeast')
