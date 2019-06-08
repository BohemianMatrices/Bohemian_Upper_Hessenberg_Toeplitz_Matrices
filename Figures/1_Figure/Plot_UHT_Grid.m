clf;
close all;
clear;

fig = figure(1);
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'inches';
fig.Units = 'inches';
fig.PaperPosition = [0, 0, 6, 4];    % Check this
fig.PaperSize = [6, 4];           % And this
fig.Position = [0.12, 0.12, 5.88, 3.88];  % And this...
fig.Resize = 'off';
fig.InvertHardcopy = 'off';
fig.Color = [1,1,1];


xlabel('Re');
ylabel('Im');

axis equal

% Set up the axes properties
ax = gca;
ax.XLim = [-4.2, 4.2];
ax.YLim = [-2.8, 2.8];
% ax.XTick = [0, 5000, 10000, 15000, 20000, 25000];    % The locations of the tick marks
% ax.XTickLabels = {'0', '5000', '10000', '15000', '20000', '25000'};
ax.TickLabelInterpreter = 'LaTeX';
% ax.YTick = [1e-2, 1e-1, 1e-0, 1e1, 1e2, 1e3];
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';
ax.Box = 'on';
% ax.LineWidth = 1.5;
ax.FontSize = 10;



saveas(gcf, 'UHT_Grid.pdf');

