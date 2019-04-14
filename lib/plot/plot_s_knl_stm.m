function plot_s_knl_stm(session,channel,fold,probe)
% Plot stimulus kernel of specific s-model for given probe
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - fold: integer scalar
%   Fold number
% - probe: 2-by-1 integer vector
%   [x,y] postion of a probe

stm = get_s_knls(session,channel,fold);

% time-delay map
map = squeeze(stm(probe(1),probe(2),:,:));

create_figure('S-Model - Stimulus Kernel');

plot_time_delay_map(map);

title(sprintf('Stimulus kernel of S-Model for probe (%d, %d), and fold #%d',probe(1),probe(2),fold));
end