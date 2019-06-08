[workingDir, ~, ~] = fileparts(mfilename('fullpath'));

% -------------------- %
% Without real         %
% -------------------- %
margin = struct('bottom', -2.8,  ...
                   'top',  2.8, ...
                  'left', -4.2, ...
                 'right',  4.2);

options = struct('height', 7000, ...
             'ignoreReal', true, ...
                 'margin', margin, ...
        'backgroundColor', [1, 1, 1]);

pFilename = processData(workingDir, options);

% -------------------- %
% Greyscale            %
% -------------------- %
T = [100, 100, 100;
     25, 25, 25;
     0, 0, 0]/255;
x = [0, 0.2, 1.0];

processImage(workingDir, pFilename, T, x, options);

% -------------------- %
% With real            %
% -------------------- %

margin = struct('bottom', -0.0004,  ...
                   'top',  0.0004, ...
                  'left', -4.2, ...
                 'right',  4.2);

% 1px = (0.0004 - (-0.0004))*7000px/(2.8 - (-2.8))

options = struct('height', 1, ...
             'ignoreReal', false, ...
                 'margin', margin, ...
        'backgroundColor', [1, 1, 1]);

pFilename = processData(workingDir, options);

% -------------------- %
% Greyscale            %
% -------------------- %
T = [100, 100, 100;
     25, 25, 25;
     0, 0, 0]/255;
x = [0, 0.2, 1.0];

% -------------------- %
% Without real         %
% -------------------- %
processImage(workingDir, pFilename, T, x, options);