function [a,b] = get_nonlin_params(session,channel,fold)
% Get paramters of nonlinearity
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
% - a: scalar
%   Scale
% - b: scalar
%   Bias

model = load_model(session,channel,fold);
a = model.set_of_params.params(1);
b = model.set_of_params.b0;
end