clf;
close all;
clear;

fig = figure(1);
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'inches';
fig.Units = 'inches';
fig.PaperPosition = [0, 0, 6, 4];
fig.PaperSize = [6, 4];
fig.Position = [0.12, 0.12, 5.88, 3.88];
fig.Resize = 'off';
fig.InvertHardcopy = 'off';
fig.Color = [1,1,1];

% Load the log max height file
fileID = fopen('../../Data/logMaxCharHeight_50000.csv','r');
formatSpec = '%f';
pts = fscanf(fileID, formatSpec);
fclose(fileID);

% Convert to log_e
pts = pts/log10(exp(1));

% Convert to differences
pts = pts(2:length(pts)) - pts(1:(length(pts)-1));

plot(0:(length(pts)-1), pts, 'k.', 'MarkerSize', 3);
hold on;
plot(0:(length(pts)-1), log(1 + (1+sqrt(5))/2)*ones(length(pts),1), 'k-', 'LineWidth', 2);
xlabel('$n$');
ylabel('$\log \tau_{n+1} - \log \tau_n$');

% Set up the axes properties
ax = gca;
ax.XLim = [0, 50000];
ax.YLim = [0.9623, 0.96243];
ax.XTick = 0:10000:50000;    % The locations of the tick marks
ax.XTickLabels = {'0', '10,000', '20,000', '30,000', '40,000', '50,000'};
ax.TickLabelInterpreter = 'LaTeX';
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';
ax.FontSize = 10;

saveas(gcf, 'MaxHeightLogDiff_50000.pdf');

