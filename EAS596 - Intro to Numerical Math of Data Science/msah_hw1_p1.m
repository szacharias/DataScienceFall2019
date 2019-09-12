function [ root , nIters ] = msah_hw1_p1(f , a , b ) 

clc
format long

% Variables 

startingRange = a ;
endingRange = b; 
midPoint = (startingRange + endingRange) /2 ; 

errorTolerance = 1e-6 ;
% b-a < errorCriteria

iterationLimit  = 1000;
% if numbers of iterations exceeds 1000 return error using eror function 

% Solve
for iteration = 1 : iterationLimit 
    
    % Find Range
    if f(startingRange) * f(midPoint) < 0 
        endingRange = midPoint; 
    elseif f(endingRange) * f(midPoint) < 0 
        startingRange = midPoint; 
    end 
    
    % Ending Criteria - Error Tolerance
    if abs(endingRange - startingRange ) < errorTolerance
       fprintf("Success")
       nIters = iteration
       root = (endingRange + startingRange )/ 2  
       break; 
    end
    
    % Ending Criteria - Iterations
    if abs(endingRange - startingRange ) > errorTolerance && iteration == iterationLimit
        error( "Iterations Exceeded" )
    end
    
    midPoint = (startingRange + endingRange ) / 2 ;
    
end 

end

