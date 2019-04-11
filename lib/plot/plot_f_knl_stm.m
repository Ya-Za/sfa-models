function plot_f_knl_stm(session,channel,fold,probe)
% Plot stimulus kernel of specific f-model for given probe
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

knl = get_f_knl_stm(session,channel,fold);

% time-delay map
map = squeeze(knl(probe(1),probe(2),:,:));

createFigure('F-Model - Estimated Stimulus Kernel');

plot_time_delay_map(map);

title(sprintf('Estimated stimulus kernel with F-Model for probe (%d, %d), and fold #%d',probe(1),probe(2),fold));
end