function [id] = get_id(session,channel)
% Get neuron's ID
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
% - id: char vector
%   Neuron's ID based on given `session` and `channel`

id = sprintf('%d%02d',session,channel);
end