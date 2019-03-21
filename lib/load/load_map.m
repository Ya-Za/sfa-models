function [map] = load_map(session,channel,prb)
% Load map of bases for a given probe
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - prb: scalar
%   Probe index
%
% Returns
% -------
% - map: array(time,delay,iteration)
%   Map of bases in time/delay grid

info = get_info();

fullfilename = fullfile(...
    info.folders.bases,...
    get_id(session,channel),...
    sprintf('prb%02d.mat',prb));

file = load_file(fullfilename);
map = file.map;
end
