function [] = msah_hw3_p6()

clc
format short

% === Part A ===

M = [[0.7 0.2 0.2 0.1];...
    [0.1 0.6 0.1 0.1];...
    [0.1 0.2 0.6 0.1];...
    [0.1 0 0.1 0.7]];
P = [[0.3];...
    [0.15];...
    [0.45];...
    [0.1]];
% Party A and C will have the equal chance of winning
MP = M * P


% Party A will most likely win 
MP2 = M * M * P


% === Part B ===
i = 0 ;
finalMP = M ;
while i < 99
    i = i+1 ; 
    finalMP = M * finalMP;
    %disp(i)
end

finalMP = finalMP * P