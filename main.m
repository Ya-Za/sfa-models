function [] = main()
% Main function
%
% to see log file
% >>> type('log.txt');
%
% Notations
% ---------
% - trn  : train
% - val  : validation
% - tst  : test
% - stm  : stimulus kernel
% - psk  : post spike kernel
% - off  : offset kernel
% - idxs : indexes
% - resp : responses
% - stim : stimuli
% - prb  : probe
% - fr   : firing rate
% - fr_ss: self sufficient firing rate

% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
session = 20150511;
channel = 15;

% close all figures and clear command window
close('all');
clc();

% add `lib`, and all its subfolders to the path
addpath(genpath('lib'));

% copy command widnow to `log.txt` file
diary('log.txt');

% display current date/time
disp(datetime('now'));

% start main timer
main_timer = tic();

% S-Model
% smodel(session,channel);
% % F-Model
% fmodel(session,channel);
% % A-Model
% amodel(session,channel);
% Plot some results
plot_results(session,channel)

fprintf('\n\n');
toc(main_timer);
diary('off');
end
