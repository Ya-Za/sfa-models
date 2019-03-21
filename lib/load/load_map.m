function [map] = load_map(session,channel,prb)
% Load data
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - prb: scalar
%   Probe index

info = get_info();

fullfilename = fullfile(...
    info.folders.bases,...
    get_id(session,channel),...
    sprintf('prb%02d.mat',prb));

file = load_file(fullfilename);
map = file.map;
end
