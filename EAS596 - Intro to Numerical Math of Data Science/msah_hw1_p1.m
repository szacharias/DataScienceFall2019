% clear workspace
clc
clear
format long

% === Question Notes ===

% 1. Test function by computing the root of sin(x) using an initial range of
% [2,4]

% 2. in the range [2 , 10 ] there are three roots of sin(x)
% Using that range, use your function to compute the root.
% will function be able to find the other two roots?explain

% 3. if success return both roots and the number of iterations needed

% 4. if !( f(a) * f(b) < 0 ) return an error with error function

% === Question Notes End ===


% ===== Variables =====

errorCriteria = 1e-6 ;
% b-a < errorCriteria

iterationLimit  = 1000;
% if numbers of iterations exceeds 1000 return error using eror function

prompt=input('Function to solve:','s');
recievedFunction=inline(prompt);
% TODO : inline is deprecated?
% Function to solve

% ===== Variables End =====



for i = 1:1000
    
end
