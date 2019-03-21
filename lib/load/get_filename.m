function [filename] = get_filename(session,channel)
% Get neuron's filename
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
% - filename: char vector
%   Neuron's filelname based on given `session` and `channel`

filename = [get_id(session,channel),'.mat'];
end