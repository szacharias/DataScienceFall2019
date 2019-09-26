function [length] = msah_hw3_p2(A, i, j)
 
clc
format long


% === Variables === 
% TODO Comment out this for testing script
% A = [[0 1 0 1 0];...
%     [0 0 1 0 1];...
%     [1 0 0 0 1];...
%     [0 0 1 1 0];...
%     [0 0 0 1 0]];
A = [[0 3 100 7];...
    [8 0 2 100];... 
    [5 100 0 1];...
    [2 100 100 0]];

% Setting tempMatrix to calculate steps distance
tempMatrix = A * A



% Return Value
length = 1 ;
foundReturn = 0;



% Notes 
% A is adjancy matrix 
% i is departure point
% j mininum path length
% if path > 20 , return error

% === Verify if adjacent ===

% Checking Conditions -> self to self

% ===  Check steps 1 first === 
if A(i, j ) ~= 0 
    foundReturn = 1;
% self to self 
end


% === While Loop === 
% if no answer for step 1 go into while
% times matrix tempMatrix to A to get i+1 steps 
while  foundReturn ==0 & length < 20
    length = length + 1;
    if tempMatrix(i , j) ~= 0 
        foundReturn = 1; 
    else
        tempMatrix = tempMatrix * A
    end
    
        
end


% Error Message
if length > 20 & foundReturn ==0
    error("No Found Path after 20 iterations")
end

% Verify Answer
length

