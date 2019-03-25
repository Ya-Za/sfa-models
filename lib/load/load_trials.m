function [trials] = load_trials(session,channel)
% Load seperated trials for train/validation/test data sets 
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% 
% Returns
% -------
% - trials: struct (need more details)
%   Set of trials for train/validation/test data sets

info = get_info();

fullfilename = fullfile(...
    info.folders.data,...
    get_filename(session,channel));

file = load_file(fullfilename);
trials = file.trials;
end
