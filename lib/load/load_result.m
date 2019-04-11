function [result,fullfilename] = load_result(session,channel,fold)
% Load results of a neural model for a given fold number
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
% - result: struct (todo: need more details)
%   Results
% - fullfilename: char vector
%   Filename of saved model

info = get_info();

fullfilename = fullfile(...
    info.folders.results,...
    get_id(session,channel),...
    sprintf('fold%02d.mat',fold));

result = load_file(fullfilename);
end
