function [Path_Length] = kashyapb_hw3_p2(A, i, j)
 
format long

 A = [[0 1 0 1 0];...
     [0 0 1 0 1];...
     [1 0 0 0 1];...
     [0 0 1 1 0];...
     [0 0 0 1 0]];

% To define the Steps needed to calculate distance, we use Temp

Temp = A * A;

Path_Length = 1 ;
R = 0;
 
% A is the adjacency matrix 
% i is the departure point
% j is the mininum path length to be calculated
% Error returned if the path is greater than 20

% Verifying the Adjacency Matrix by checking the First step
if A(i, j) ~= 0 
    R = 1;
end


% While Loop is called if Adjacency matrix = 0
%If Return = 1, then Temp is mulltiplied with Adjacency matrix
while  R ==0 && Path_Length < 20
    Path_Length = Path_Length + 1;
    if Temp(i , j) ~= 0 
        R = 1; 
    else
        Temp = Temp * A;
    end     
end

if Path_Length > 20 && R ==0
    error("Path after 20 iterations is not found")
end

Path_Length; %Verifying the Final Path Length