function resp = get_resp(session,channel,fold)
% Get true response of specific neuron
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
%   (trial x time) response

result = load_result(session,channel,fold);
resp = result.resp;
end