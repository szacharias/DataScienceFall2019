function [] = msah_hw3_p1()


clc
format short
%=== Solution ===
% Q1 1 solution
% Q2 infinite solution
% Q3 no solution


% === Variables ===
x0 = 0 ;
x1 = 0 ;
x2 = 0 ;
x3 = 0 ;


% Part 1
Part1A = [[2, 4, 1, 6];...
    [-2, 0 ,2 ,1];...
    [-2, 6 ,2, 1];...
    [-8, -2, 1 ,1]];

Part1B = [[7];...
    [12];...
    [0];...
    [-11]];

% Part2
Part2A = [[2, 4, 1, 6];...
    [-2, 0 ,2 ,1];...
    [-2, 6 ,2, 1];...
    [14, -14, -11 ,0]];

Part2B = [[7];...
    [12];...
    [0];...
    [-29]]; 



% Part 3


Part3A = [[2, 4, 1, 6];...
    [-2, 0 ,2 ,1];...
    [-2, 6 ,2, 1];...
    [14, -14, -11 ,0]];

Part3B = [[7];...
    [12];...
    [0];...
    [0]]; 

% === Variables End ===


[x0,x1,x2,x3] = findEachXs([Part1A,Part1B])


[x0,x1,x2,x3] = findEachXs([Part2A, Part2B])


[x0,x1,x2,x3] = findEachXs([Part3A, Part3B])


end 

function[x0, x1, x2, x3] = findEachXs(augementedMatrix)
D = rref(augementedMatrix)

x0 = D(1,5);
x1 = D(2,5);
x2 = D(3,5);
x3 = D(4,5);

end
