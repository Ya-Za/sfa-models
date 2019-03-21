function [model] = load_model(session,channel,fold)
% Load neural model for a given fold number
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - fold: integer scalar
%   Fold number
%
% Returns
% -------
% - model: struct (todo: need more details)
%   Neural model

info = get_info();

fullfilename = fullfile(...
    info.folders.models,...
    get_id(session,channel),...
    sprintf('fold%02d.mat',fold));

model = load_file(fullfilename);
end
