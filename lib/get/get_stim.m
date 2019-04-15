function stim = get_stim(session,channel,fold)
% Get stimuli of specific neuron
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
% - stim: 2D matrix
%   (trial x time) response

result = load_result(session,channel,fold);
stim = result.stim;
end