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


% N: number of trials
% T: number of times
[N, T] = size(file.stim);
tsaccade = ceil(T / 2) * ones(N, 1);

% todo:
% - `STIM` -> `stim`
% - `RESP` -> `resp`
% - `tsaccade` -> `tsac`
data = struct(...
    'STIM',code2stim(file.stim),...
    'stimcode',double(file.stim),...
    'tsaccade',tsaccade,...
    'RESP',double(file.resp));
end
