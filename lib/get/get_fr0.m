function fr0 = get_fr0(session,channel,fold,trial)
% Get firing rate of null model
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
% - fr0: scalar
%   null firing rate

[a,b] = get_nonlin_params(session,channel,fold);

[~,psk,off] = get_s_knls(session,channel,fold);

r = get_resp(session,channel,fold);
r = r(trial,:);

fr0 = a * logsig(conv(r,psk,'same') + off + b);
end