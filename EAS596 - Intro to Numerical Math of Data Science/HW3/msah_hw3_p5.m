function [] = msah_hw3_p5()


clc
format short


%  === Variables ===
% Question a

MA = [[1/4 1/3];...
    [3/4 2/3]];
MAP = [[2/3];...
    [1/3]];

% Question b 
MB = [[ 1/2 1/3 0];...
    [0 2/3 1/2];...
    [ 1/2 0 1/2]];
MBP = [[1/3];...
    [1/6];...     
    [1/2]];

% Question C

MC = [[1/4 1/3  1/2];...
    [1/2 1/3 1/6 ];...
    [1/4 1/3 1/3]];
MCP = [[1/4 ];...
    [1/2] ;...
    [1/4]];

% === Variables End ===

[questionAP1, questionAP2] = timesMatrices(MA, MAP)
[questionBP1, questionBP2 ] = timesMatrices(MB ,MBP)
[questionCP1, questionCP2 ]= timesMatrices(MC, MCP)


end

function[returnListP1, returnListP2] = timesMatrices(M , P)
returnListP1 = M*P;
returnListP2 = M * M * P;
end
