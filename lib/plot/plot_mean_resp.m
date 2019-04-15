function plot_mean_resp(session,channel,fold,period,probe,window)
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
% - period: [scalar, scalar]
%   Time period from saccade
% - probe: 2-by-1 integer vector
%   [x,y] postion of a probe
% - window: scalar
%   Length of response window

sw = 21; % smoothing window
colors = lines(2); % color
line_width = 3; % width of line
alpha = 0.2; % color alpha

times = 1:window;

[mean_resp, se_resp, mean_s_fr, se_s_fr] = ...
    get_mean_resp(session,channel,fold,period,probe,window);


mean_resp = smoothdata(mean_resp, 'gaussian', sw);
se_resp = smoothdata(se_resp, 'gaussian', sw);
mean_s_fr = smoothdata(mean_s_fr, 'gaussian', sw);
se_s_fr = smoothdata(se_s_fr, 'gaussian', sw);


create_figure('Mean Response');

% resp
plot(times, mean_resp, ...
    'DisplayName', '  E[Response]', ...
    'LineWidth', line_width, ...
    'Color', colors(1,:));
hold('on');
patch(...
    'XData', [times, flip(times)], ...
    'YData', [mean_resp - se_resp, flip(mean_resp + se_resp)], ...
    'DisplayName', 'SE[Response]', ...
    'LineStyle', 'none', ...
    'FaceColor', colors(1,:), ...
    'FaceAlpha', alpha);

% s-model firing rate
plot(mean_s_fr, ...
    'DisplayName', '  E[S-Model]', ...
    'LineWidth', line_width, ...
    'Color', colors(2,:));
patch(...
    'XData', [times, flip(times)], ...
    'YData', [mean_s_fr - se_s_fr, flip(mean_s_fr + se_s_fr)], ...
    'DisplayName', 'SE[S-Model]', ...
    'LineStyle', 'none', ...
    'FaceColor', colors(2,:), ...
    'FaceAlpha', alpha);
hold('off');

xticks([1,50:50:window]);
yticks([0, 100]);

title(sprintf('Mean response for probe (%d, %d) at period (%d, %d)', ...
    probe(1), probe(2), period(1), period(2)));
xlabel('Time (ms)');
ylabel('Firing rate (spk/s)');
legend();

set_axis();
end
