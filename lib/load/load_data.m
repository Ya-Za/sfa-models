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
    get_filename(session,channel));

file = load_file(fullfilename);

% todo:
% - `STIM` -> `stim`
% - `RESP` -> `resp`
data = struct(...
    'STIM',code2stim(file.stimcode),...
    'stimcode',double(file.stimcode),...
    'tsaccade',double(file.tsaccade),...
    'RESP',double(file.resp));
end
