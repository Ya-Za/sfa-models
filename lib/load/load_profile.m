function [profile] = load_profile(session,channel)
% Load neural profile
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
% - profile: struct (todo: need more details)
%   Neural profile

info = get_info();

fullfilename = fullfile(...
    info.folders.profiles,...
    get_filename(session,channel));

profile = load_file(fullfilename);
end
