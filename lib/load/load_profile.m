function [profile] = load_profile(session,channel)
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
    info.folders.profiles,...
    get_filename(session,channel));

profile = load_file(fullfilename);
end
