function fr = get_s_fr(session,channel,fold)
% Get firing rate of specific s-model
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
% - resp: 2D matrix
%   (trial x time) firing rate

result = load_result(session,channel,fold);
fr = result.fr;
end