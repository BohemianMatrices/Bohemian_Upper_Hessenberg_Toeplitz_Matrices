% ----------------------------------------------------------------------- %
% AUTHOR .... Steven E. Thornton (Copyright (c) 2017)                     %
% EMAIL ..... sthornt7@uwo.ca                                             %
% UPDATED ... Jan. 14/2018                                                %
%                                                                         %
% Convert a text file of polynomials (with optional density information)  %
% into a .mat file with the roots of all polynomials (and optionally      %
% their densities.) The saved .mat file will store the roots in single    %
% complex precision.                                                      %
%                                                                         %
% INPUT                                                                   %
%   filename ....... A text file to be processed where each line takes    %
%                    the form:                                            %
%                        count c{n-1} ... c1 c0                           %
%                    where count represents the density of the polynomial %
%                    on that line and the polynomial takes the for        %
%                        x^n + c{n-1} x^{n-1} + ... + c1 x + c0           %
%   n .............. Size of matrix (degree of polynomials)               %
%   has_weights .... (bool). When true the first value on each line is    %
%                    assumed to be the weight of the characteristic       %
%                    polynomial.                                          %
%   sep ............ The character used to separate values in the input   %
%                    file.
%                                                                         %
% LICENSE                                                                 %
%   This program is free software: you can redistribute it and/or modify  %
%   it under the terms of the GNU General Public License as published by  %
%   the Free Software Foundation, either version 3 of the License, or     %
%   any later version.                                                    %
%                                                                         %
%   This program is distributed in the hope that it will be useful,       %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of        %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         %
%   GNU General Public License for more details.                          %
%                                                                         %
%   You should have received a copy of the GNU General Public License     %
%   along with this program.  If not, see http://www.gnu.org/licenses/.   %
% ----------------------------------------------------------------------- %
function processPolyFile(inFile, outFile, n, has_weights, sep)
    
    if has_weights
        fprintf('has_weights = true\n');
    else
        fprintf('has_weights = false\n');
    end
    
    fileID = fopen(inFile, 'r');
    
    if has_weights
        formatSpec = ['%u', sep, ' ', repmat(['%d', sep, ' '], 1, n-1), '%d'];
    else
        formatSpec = [repmat(['%d', sep, ' '], 1, n-1), '%d'];
    end
    
    % Load file as matrix
    if has_weights
        A = fscanf(fileID, formatSpec, [n+1, Inf]);
    else
        A = fscanf(fileID, formatSpec, [n, Inf]);
    end
    A = A'; % Transpose
    
    numPolys = size(A, 1);
    
    fprintf(['Computing roots of ', int2str(numPolys), ' degree ', int2str(n), ' polynomials\n']);
    
    eigVals = complex(single(zeros(numPolys, n)));
    
    if has_weights
        weights = uint64(zeros(numPolys, n));
    end
    
    % Loop through each row of A and compute roots
    for i=1:numPolys
        
        if mod(i, 100000) == 0
            fprintf([int2str(i), ' of ', int2str(numPolys), '\n']);
        end
        
        % Compute roots (eigenvalues)
        if has_weights
            eigVals(i, :) = roots([1, A(i, 2:end)]);
            weights(i, :) = A(i, 1);
        else
            eigVals(i, :) = roots([1, A(i, :)]);
        end
    end
    
    if has_weights
        save(outFile, 'eigVals', 'weights', '-v7.3');
    else
        save(outFile, 'eigVals', '-v7.3');
    end
    
end