function fr0 = get_fr0(session,channel,fold)
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
%
% Returns
% -------
% - fr0: scalar
%   null firing rate

[a,b] = get_nonlin_params(session,channel,fold);

[~,psk,off] = get_s_knls(session,channel,fold);

r = get_resp(session,channel,fold);

fr0 = zeros(size(r));
for i = 1:size(r,1)
    fr0(i,:) = a * logsig(conv(r(i,:),psk,'same') + off + b);
end
end