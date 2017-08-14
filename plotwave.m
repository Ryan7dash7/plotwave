function plotwave(varargin)
%PLOTWAVE Plot waveforms.
%   PLOTWAVE plots waveforms saved by a LeCroy oscilloscope. The waveforms
%   must be saved to CSV, DAT, or TXT files. If a waveform is saved to a
%   DAT or TXT file, the filename must start with 'C1', 'C2', 'C3', or
%   'C4'.
%
%   PLOTWAVE([CH1 CH2 CH3 CH4]) plots only the selected channels. CH is a
%   logical used to select which channels to plot.
%
%   PLOTWAVE([CH1 CH2 CH3 CH4],[G1 G2 G3 G4]) applies a gain G to each
%   channel.

%   Version 2017.08.14
%   Copyright 2017 Ryan McGowan

if nargin > 2
    error('Too many input arguments.');
end

if nargin == 0
    ch = [true true true true];
    g = [1 1 1 1];
elseif nargin == 1
    ch = varargin{1};
    g = [1 1 1 1];
elseif nargin == 2
    ch = varargin{1};
    g = varargin{2};
end

[filename,pathname] = uigetfile({'*.csv;*.dat;*.txt'});
[~,~,ext] = fileparts([pathname filename]);
switch lower(ext)
    case '.csv'
        [~,~,raw] = xlsread([pathname filename]);
        timePerDiv = raw{4,2};
        dt = raw{6,2};
        t = (0:dt:timePerDiv*10)';
        if ch(1)
            C1 = [t cell2mat(raw(31:end,1))];
        end
        if ch(2)
            C2 = [t cell2mat(raw(31:end,2))];
        end
        if ch(3)
            C3 = [t cell2mat(raw(31:end,3))];
        end
        if ch(4)
            C4 = [t cell2mat(raw(31:end,4))];
        end
    case {'.dat','.txt'}
        if ch(1) && exist([pathname 'C1' filename(3:end)],'file')
            C1 = load([pathname 'C1' filename(3:end)]);
        end
        if ch(2) && exist([pathname 'C2' filename(3:end)],'file')
            C2 = load([pathname 'C2' filename(3:end)]);
        end
        if ch(3) && exist([pathname 'C3' filename(3:end)],'file')
            C3 = load([pathname 'C3' filename(3:end)]);
        end
        if ch(4) && exist([pathname 'C4' filename(3:end)],'file')
            C4 = load([pathname 'C4' filename(3:end)]);
        end
end

% Create the plot
if exist('C1','var')
    plot(C1(:,1),C1(:,2)*g(1),'y')
    hold on
end
if exist('C2','var')
    plot(C2(:,1),C2(:,2)*g(2),'m')
    hold on
end
if exist('C3','var')
    plot(C3(:,1),C3(:,2)*g(3),'c')
    hold on
end
if exist('C4','var')
    plot(C4(:,1),C4(:,2)*g(4),'g')
    hold on
end
hold off
axis tight
grid on
end

