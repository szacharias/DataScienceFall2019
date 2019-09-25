 
format long
clc 

% Variable
x = pi/ 3 ;
stepSize = logspace(-16 ,  -1 );
stepSizeLength = length(stepSize) ; 

minError = 1 ;
stepSizeOutput = 0 ;


% Solve
for stepsIteration = 1 : stepSizeLength 
    
    functionF(stepsIteration) = ( sin(x + stepSize(stepsIteration)) - sin(x)) / stepSize(stepsIteration) ;
    O(stepsIteration) = abs(cos(x) -  functionF(stepsIteration)); 
    
    % Show min Error
    if minError > O(stepsIteration)
        minError = O(stepsIteration);
        stepSizeOutput = stepSize(stepsIteration);
    end
    
end

% Plot
loglog(stepSize , O)
xlabel('Step Sizes H')
ylabel('Error Rate O(h)')
 
fprintf('Minimum Error is %d' , minError) 
fprintf('\nBest StepSize %d\n' , stepSizeOutput)