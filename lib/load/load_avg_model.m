function [model,fullfilename] = load_avg_model(session,channel)
% Load average neural model
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
% - model: struct (todo: need more details)
%   Neural model
% - fullfilename: char vector
%   Filename of saved model

info = get_info();

fullfilename = fullfile(...
    info.folders.avg_models,...
    get_filename(session,channel));

model = load_file(fullfilename);
end
