function [model] = load_model(session,channel,fold)
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
    info.folders.models,...
    get_id(session,channel),...
    sprintf('fold%02d.mat',fold));

model = load_file(fullfilename);
end
