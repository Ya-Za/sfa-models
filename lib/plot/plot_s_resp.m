function plot_s_resp(session,channel,fold,trial)
% Plot response of specific s-model for given trial
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

info = get_info();
times = info.times;

s = 5; % scale spikes
colors = lines(2);

s_fr = get_s_fr(session,channel,fold);
s_fr = s_fr(trial,:);

create_figure('S-Model - Response');

% firing rate
plot(times,s_fr,...
    'LineWidth',2,...
    'Color',colors(1,:));

xticks([times(1), 0, times(end)]);
yticks(round([0, max(s_fr)],2));

% true spike train
hold('on');
resp = get_resp(session,channel,fold);
resp = resp(trial,:);
resp = reshape(resp,1,[]);
resp = [zeros(size(resp));s * resp];

times = reshape(times,1,[]);
times = [times;times];

plot(times,resp,...
    'LineWidth',3,...
    'Color',colors(2,:));
hold('off');

% title(sprintf('Response of S-Model for trial #%d',trl));
title(sprintf(...
    'Response of S-Model for trial #%d\nDelta log-likelihood: %g',...
    trial,...
    get_dll(session,channel,fold,trial)));
xlabel('Time from saccade onset (ms)');
ylabel('Firing rate (spk/s)');

set_axis();
end
