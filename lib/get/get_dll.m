function dll = get_dll(session,channel,fold,trial)
% Get true delta log-likelihood of specific neuron
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - fold: integer scalar
%   Fold number
% - trial: scalar
%   Trial index
%
% Returns
% -------
% - dll: scalar
%   Delta log-likelihood

r = get_resp(session,channel,fold);
r = r(trial,:);

fr = get_s_fr(session,channel,fold);
fr = fr(trial,:);
fr = fr / 1000 + eps;

fr0 = get_fr0(session,channel,fold,trial);
fr0 = fr0 / 1000 + eps;

dll = sum(r .* log(fr ./ fr0) - fr + fr0);
end