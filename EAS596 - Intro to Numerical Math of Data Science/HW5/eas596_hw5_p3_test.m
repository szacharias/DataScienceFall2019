function [] = eas596_hw5_p3_test()
%EAS596_HW3_TEST Automatic testing for EAS 596, HW 3

    for AB=['a','b']

        %     List of m-files
        f = sprintf('*hw5_p3%s.m', AB);
        d = dir(f);

        %     Strip the stuff that UBLearns adds
        for i=1:length(d)                   
            stripUBLearns(d(i).name);
        end

        %     Updated list of files
        d = dir(f); % List of m-files

        %     Output CSV will be:
        %     name correctCall correctResult1 correctResult2 correctResult3
        results = cell(length(d), 4);

        for i=1:length(d)                       % Iterate over each result
            f = d(i).name;                      % Name of the file
            fprintf('Testing %s\n', f);
            [name, ~, ~, fh] = eas596_parsefile(f);         % Parse the file

            results{i, 1} = name;

            % Square matrix
            A = rand(5,5);

            % Is this a function with the correct call and output?    
            try [Q, R] = fh(A);
                results{i, 2} = 1;            
                results{i, 3} = CheckQR(A, Q, R);

                %   Rectangular 
                A = rand(8,3);
                [Q, R] = fh(A);
                results{i, 4} = CheckQR(A, Q, R);

            catch  % Not a correct call 
                for j=2:size(results,2)
                    results{i,j} = 0;
                end
            end

        end
        close all;
        T = cell2table(results, 'VariableNames',{'Name', 'CorrectCall', ...
                'CorrectResult1', 'CorrectResult2'});
        f = sprintf('HW5_P3%s_Results.csv', AB);
        writetable(T, f);
    end
end

function [result] = CheckQR(A, Q, R)
    result = (norm(Q*R-A)<1E-8);
    result = result && (max(max(abs(tril(R,-1))))==0);
    QtQ = Q'*Q;
	result = result && (norm(QtQ-eye(size(QtQ)))<1E-8);
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