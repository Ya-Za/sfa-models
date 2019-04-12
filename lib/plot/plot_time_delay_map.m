function plot_time_delay_map(map)
% Plot time delay sensitivity map
%
% Parameters
% ----------
% - map: matrix
%   (time x delay) sensitivity map

info = get_info();
times = info.times;
[T,D] = size(map);

% imagesc(map);
% axis('xy');

surf(map);
view([0,90]);
shading('interp');

colorbar('XTick', round([min(map(:)),max(map(:))],2));

xlabel('Delay (ms)');
ylabel('Time form saccade onset (ms)');

xticks([1,50:50:D]);

tidx = [1,ceil(T / 2),T];
yticks(tidx);
yticklabels(string(times(tidx)));

set_axis();
end