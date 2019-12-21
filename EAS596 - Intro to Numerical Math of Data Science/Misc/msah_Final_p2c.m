function msah_Final_p2c(t, theta1, L1, L2, h) 

% use previos functions
[ x, theta2] = msah_Final_p2b(theta1, L1, L2, h);


% compute velocity  
try
    % use x to calculate velocity
    % forward finite difference
    % Forward finite difference example
    % y_diff = (y(2:end) - y(1:end-1)) ./ h
catch
    % backward finite difference
    % backward finite difference example
    % y_diff = (y(2:end) - y(1:end-1)) ./ h
end


% compute acceleration 
try
    %forward finite difference
catch
    % backward finite difference
    
end

% Plot Graph
% must have axis labels and titles

% plot 1
%subplot(5,1,1),plot(theta1,t,'b') 
% grid on
% xlabel('theta1')
% ylabel('t')
% title('theta1 versus t')

%plot2
%subplot(5,1,2),plot(theta2,t,'b')
% grid on
% xlabel('theta2')
% ylabel('t')
% title('theta2 versus t')

% plot3
%subplot(5,1,3),plot(x,t,'b')
% grid on
% xlabel('x')
% ylabel('t')
% title('x versus t')

%plot 4
%subplot(5,1,4),plot(v,t,'b')
% grid on
% xlabel('velocity')
% ylabel('t')
% title('velocity  versus t')

%plot 5
%subplot(5,1,5),plot(a,t,'b') 
% grid on
% xlabel('acceleration')
% ylabel('t')
% title('acceleration versus t')


end

% xForward=x(1:end-1);
% dFForward=(F(2:end)-F(1:end-1))/h;
% xBackward=x(2:end);
% dFBackward=(F(2:end)-F(1:end-1))/h;