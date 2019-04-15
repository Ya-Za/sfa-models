function plot_results(session,channel)
% Plot some results
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number

fprintf('===== Plot some resutls =====\n\n');
main_timer = tic();

probe = [7, 6]; % probe
fold = 1; % fold number
trial = 1; % trial number
period = [-400 -100]; % time period from saccade
window = 150; % length of response window

% plot
% - stimulus kernel of s-model
plot_s_knl_stm(session,channel,fold,probe);
% - estimated stimulus kernel with f-model
plot_f_knl_stm(session,channel,fold,probe);
% - average of estimated stimulus kernels with a-model
plot_a_knl_stm(session,channel,probe);
% - response firing rate of s-model
plot_s_fr(session,channel,fold,trial);
% - mean response
plot_mean_resp(session,channel,fold,period,probe,window);
% - Kolmogorov Smirnov (KS) plot
plot_ks(session,channel,fold,period);

fprintf('\n\n');
toc(main_timer);
end