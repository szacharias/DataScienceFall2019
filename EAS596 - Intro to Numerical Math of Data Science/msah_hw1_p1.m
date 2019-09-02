% clear workspace
clc
clear
format long

who
% Gives Details regarding size space allocation and the class of the
% variables

% === Self Notes ===
%diary
% Record sessions from matlab
%dairy off
% Stop the recording of the session
% -- dairy on --
% Continue the recording of the Session
% doc plot 
% Show document of "plot"

% Checking Variables
% % error = abs(endingRangeQ1 - startingRange ) - errorTolerance
% % endingRangeQ1 
% % startingRange
% % output = (endingRangeQ1 + startingRange) / 2

% --- Self Notes ---

% === Question Notes ===

% 1. Test function by computing the root of sin(x) using an initial range of
% [2,4]

% 2. in the range [2 , 10 ] there are three roots of sin(x)
% Using that range, use your function to compute the root.
% will function be able to find the other two roots?explain

% 3. if success return both roots and the number of iterations needed

% 4. if !( f(a) * f(b) < 0 ) return an error with error function

% --- Question Notes End ---


% ===== Variables =====

startingRange = 2 ;
endingRangeQ1 = 4;
endingRangeQ2 = 10;

midPointQ1 = (startingRange + endingRangeQ1 ) / 2 ;
midPointQ2 = (startingRange + endingRangeQ2 ) / 2 ;

plottingIncrement = 1e-2;
%

errorTolerance = 1e-6 ;
% b-a < errorCriteria

iterationLimit  = 1000;
% if numbers of iterations exceeds 1000 return error using eror function

% ===== Variables End =====
% 
% % === Plot Start ===

% Q1 
x = startingRange : plottingIncrement : endingRangeQ1; 
y = sin(x);  
x2 = startingRange : plottingIncrement :  endingRangeQ1 ;
y2 = x2 * 0 ;
figure(1)
plot(x , y , "-" , x2 , y2 , " --")

% Q2
x = startingRange : plottingIncrement : endingRangeQ2 ;
y = sin(x);
x2 = startingRange : plottingIncrement :endingRangeQ2 ; 
y2 = x2 * 0 ;
figure(2)
plot(x , y , "-" , x2 , y2 , " --")
% --- Plot End ---%


% === Q1 === 
for q = 1 : iterationLimit 
    if sin(startingRange) * sin(midPointQ1) < 0 
        endingRangeQ1 = midPointQ1; 
    elseif sin(endingRangeQ1) * sin(midPointQ1) < 0 
        startingRange = midPointQ1; 
    end 
    if abs(endingRangeQ1 - startingRange ) < errorTolerance
       fprintf("Q1 Success")
       iterationRounds = q
       root = (endingRangeQ1 + startingRange )/ 2  
       break; 
    elseif abs(endingRangeQ1 - startingRange ) > errorTolerance && q == iterationLimit
        error( "Iterations Exceeded" )
    end
    midPointQ1 = (startingRange + endingRangeQ1 ) / 2 ;
end
% --- Q1 ---

startingRange = 2 ;

% === Q2 === 
for q = 1 : iterationLimit  
    if sin(startingRange) * sin(midPointQ2) < 0 
        endingRangeQ2 = midPointQ2; 
    elseif sin(endingRangeQ2) * sin(midPointQ2) < 0 
        startingRange = midPointQ2; 
    end 
    if abs(endingRangeQ2 - startingRange ) < errorTolerance
       fprintf("Q2 Success")
       iterationRounds = q
       root = (endingRangeQ2 + startingRange )/ 2  
       break; 
    elseif abs(endingRangeQ2 - startingRange ) > errorTolerance && q == iterationLimit
        error( "Iterations Exceeded" )
    end
    midPointQ2 = (startingRange + endingRangeQ2 ) / 2 ;
end
% --- Q2 ---

% TODO Q2's written answer?