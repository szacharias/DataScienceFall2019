
% clear workspace
clc
clear
format long


formatSpec = ' %d  %d  %f ';
fileID = fopen('power_law_data.txt','r');
[d,count] = fscanf(fileID,formatSpec);
fclose(fileID);
count
N = d(1,1);
n = d(2,1);
alpha0 = d(3,1);
N
n
alpha0


% % read data for power law plotting
% data = load('power_law_data.txt');
% [DR,dc] = size(data);
% N       = data(1,1);  % number of curves
% n       = data(1,2);  % number of x points for plot
% alpha0  = data(1,3);  % exponent

% alpha = 1/2;
% n = 64;
x = (1:n)';
x = 2*x/n;
x

for j=1:N
    alpha = j*alpha0;
    
%     [y] = power_law(n,alpha,x);
%     j
%     alpha
%     y'
       
    f = @power_law;
    y = f(n,alpha,x);
%     j
%     alpha
%     y'
    
    if j == 1
        x1 = x;
        y1 = y;
        alpha1 = alpha;
    else
        
        figure(j)
        plot(x1,y1,'b',x,y,'r','LineWidth',2.5)
        axis([0 2 -1 5])
        title({'\fontsize{14} Matlab Example 1';...
            ['\fontsize{12} Power Law Behavior']})
        xlabel('\fontsize{14} x')
        ylabel('\fontsize{14} y')
        legend(['\fontsize{10} Power Law \alpha=',num2str(alpha1)],...
            ['\fontsize{10} Power Law \alpha=',num2str(alpha)],...
            'Location','Northwest')
        
        figure(100+j)
        loglog(x1,y1,'b',x,y,'r','LineWidth',2.5)
        axis([0 2 0 4])
        title({'\fontsize{14} Matlab Example 1';...
            ['\fontsize{12} Power Law Behavior']})
        xlabel('\fontsize{14} x')
        ylabel('\fontsize{14} y')
        legend(['\fontsize{10} Power Law \alpha=',num2str(alpha1)],...
            ['\fontsize{10} Power Law \alpha=',num2str(alpha)],...
            'Location','Northwest')
        
    end
    
end
