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

% Load the argmax height file
fileID = fopen('../../Data/argmaxCharHeight_50000.csv','r');
formatSpec = '%f';
pts = fscanf(fileID, formatSpec);
fclose(fileID);

n_min = 1;
n_max = 100;

p1 = plot(n_min:n_max, pts((n_min+1):(n_max+1)), 'k.', 'MarkerSize', 8);
xlabel('$n$');
ylabel('$\mu_n$');

% Set up the axes properties
ax = gca;
ax.XLim = [0, n_max];
ax.YLim = [0, 30];
ax.TickLabelInterpreter = 'LaTeX';
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';
ax.FontSize = 10;

saveas(gcf, 'Argmax.pdf');

