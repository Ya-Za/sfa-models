function [data] = load_data(session,channel)
% Load data
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number

% - STIM: 4-D boolean array (trial x width x height x time)
% - stimcode: integer matrix (trial x time)
% - tsaccade: integer vector (trial x 1)
% - RESP: boolean matrix (trial x time)

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
