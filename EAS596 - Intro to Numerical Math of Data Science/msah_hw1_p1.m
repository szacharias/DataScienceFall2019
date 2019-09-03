function [ root , nIters ] = msah_hw1_p1(f , a , b ) 

clc
format long

% ===== Variables =====

startingRange = a ;
endingRange = b; 
midPoint = (startingRange + endingRange) /2 ; 

errorTolerance = 1e-6 ;
% b-a < errorCriteria

iterationLimit  = 1000;
% if numbers of iterations exceeds 1000 return error using eror function


% === Q1 === 
for q = 1 : iterationLimit 
    if f(startingRange) * f(midPoint) < 0 
        endingRange = midPoint; 
    elseif f(endingRange) * f(midPoint) < 0 
        startingRange = midPoint; 
    end 
    if abs(endingRange - startingRange ) < errorTolerance
       fprintf("Q1 Success")
       nIters = q
       root = (endingRange + startingRange )/ 2  
       break; 
    elseif abs(endingRange - startingRange ) > errorTolerance && q == iterationLimit
        error( "Iterations Exceeded" )
    end
    midPoint = (startingRange + endingRange ) / 2 ;
end
% --- Q1 ---

end

