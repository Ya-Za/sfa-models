function [trials] = load_trials(session,channel)
% Load data
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number

info = get_info();

fullfilename = fullfile(...
    info.folders.data,...
    sprintf('%d.mat',session));

file = load_file(fullfilename);
trials = file.trials;
end
