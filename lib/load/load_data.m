function [data] = load_data(session,channel)
% Load data
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
% - STIM: boolean array(trial,width,height,time)
%   Stimuli
% - stimcode: integer matrix(trial,time)
%   Coded stimuli
% - tsaccade: integer vector(trial)
%   Saccade times
% - RESP: boolean matrix(trial,time)
%   Responses

info = get_info();

fullfilename = fullfile(...
    info.folders.data,...
    sprintf('%d.mat',session));

file = load_file(fullfilename);

% todo:
% - `STIM` -> `stim`
% - `RESP` -> `resp`
data = struct(...
    'STIM',code2stim(file.stimcode),...
    'stimcode',file.stimcode,...
    'tsaccade',file.tsaccade,...
    'RESP',file.resp.(sprintf('ch%02d',channel)));
end
