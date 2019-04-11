function plot_a_knl_stm(session,channel,probe)
% Plot average of stimulus kernels of specific a-model for given probe
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - probe: 2-by-1 integer vector
%   [x,y] postion of a probe

knl = get_a_knl_stm(session,channel);

% time-delay map
map = squeeze(knl(probe(1),probe(2),:,:));

createFigure('A-Model - Average of Estimated Stimulus Kernels');

plot_time_delay_map(map);

title(sprintf('Average of estimated stimulus kernels with A-Model for probe (%d, %d)',probe(1),probe(2)));
end