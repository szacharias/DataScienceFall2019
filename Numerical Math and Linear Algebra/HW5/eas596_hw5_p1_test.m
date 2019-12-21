function [] = eas596_hw5_p1_test()
%EAS596_HW3_TEST Automatic testing for EAS 596, HW 3


    %     List of m-files
    d = dir('*hw5_p1.m'); 

    %     Strip the stuff that UBLearns adds
    for i=1:length(d)                   
        stripUBLearns(d(i).name);
    end
    
    %     Updated list of files
    d = dir('*hw5_p1.m'); % List of m-files
    
    %     Output CSV will be:
    %     name correctCall correctResult1 correctResult2 correctResult3
    results = cell(length(d), 5);
    
    for i=1:length(d)                       % Iterate over each result
        f = d(i).name;                      % Name of the file
        fprintf('Testing %s\n', f);
        [name, ~, ~, fh] = eas596_parsefile(f);         % Parse the file

        results{i, 1} = name;
        
        % Square matrix
        A = rand(5,5)+eye(5);
        
        % Is this a function with the correct call and output?    
        try [L, U] = fh(A);
            results{i, 2} = 1;            
            results{i, 3} = CheckLU(A, L, U);
                        
            %   Rectangular 
            A = rand(8,3)+eye(8,3);
            [L, U] = fh(A);
            results{i, 4} = CheckLU(A, L, U);
            
            %   Rectangular 
            A = rand(3,8)+eye(3,8);
            [L, U] = fh(A);
            results{i, 5} = CheckLU(A, L, U);
            
        catch  % Not a correct call 
            for j=2:size(results,2)
                results{i,j} = 0;
            end
        end

    end
    close all;
    T = cell2table(results, 'VariableNames',{'Name', 'CorrectCall', ...
            'CorrectResult1', 'CorrectResult2', 'CorrectResult3'});
    writetable(T, 'HW5_P1_Results.csv');
    
end

function [result] = CheckLU(A, L, U)
    result = (norm(L*U-A)<1E-8);
    result = result && (max(max(abs(tril(U,-1))))==0);
	result = result && (max(max(abs(triu(L,+1))))==0);
end

function [] = stripUBLearns(f)
%STRIPUBLEARNS Strip the stuff that UBLearns adds during a bulk download.
%   Note: This renames the file
%   f - The file name to strip

    k = strfind(f, '_attempt_');
    
    if ~isempty(k)    
        movefile(f, f(k+29:end));
    end
    
    
end

function [user, hw, prob, fh] = eas596_parsefile(f)
%EAS596_PARSEFILE Parse the username, hw #, and problem # from a file name
%   f - The file name to parse
%   user - The student user name
%   hw - The HW #
%   prob - The problem #
%   fh - Function handle

    k = strfind(f, '_');            % Get locations of _
    user = f(1:k-1);                % The user name of the student
    
    k = strfind(f, '_hw');          % Location of hw
    hw = str2double(f(k+3));        % Pull the HW number    
         
    k = strfind(f, '_p');           % Location of file ending
    prob = str2double(f(k+2));      % Problem number   
    
    fh = str2func(f(1:end-2));
    
    
end