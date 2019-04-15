function dll = get_dll(session,channel,fold,trials,times)
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
% - trials: vector
%   Trial indeces
% - times: vector
%   Time of study
%
% Returns
% -------
% - dll: scalar
%   Delta log-likelihood

r = get_resp(session,channel,fold);

if ~exist('trials','var')
    trials = 1:size(r,1);
end
if ~exist('times','var')
    times = 1:size(r,2);
end

r = r(trials,times);

fr = get_s_fr(session,channel,fold);
fr = fr(trials,times);
fr = fr / 1000 + eps;

fr0 = get_fr0(session,channel,fold);
fr0 = fr0(trials,times);
fr0 = fr0 / 1000 + eps;

dll = sum(r .* log(fr ./ fr0) - fr + fr0, 'all') / sum(r, 'all');
end