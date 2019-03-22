function [map,delay_bases,time_bases] = decide_bases(session,channel,sigma)
% Decide about resolution of bases
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - sigma: scalar
%   Scale standard deviation
%   
% Returns
% -------
% - map: array(width,height,time basis,delay basis)
%   Map of bases for each probe
% - delay_bases: matrix(delay basis,knot)
%   Delay bases
% - time_bases: matrix(time basis,knot)
%   Time bases

info = get_info();
width = info.width;
height = info.height;
num_delays = info.num_delays;
num_times = info.num_times;
probe_time_resolution = info.probe_time_resolution;
bases_iterations = info.bases_iterations;

% bases
% - delay
delay_values = 1:num_delays;                             
delay_delta = 2 * probe_time_resolution; % todo: why is twice than `7` ms
delay_knots = make_knots(delay_values,delay_delta);
delay_bases = make_bsplie_bases(delay_values,delay_knots);

% - time
time_values = 1:num_times;
time_delta = 2 * probe_time_resolution;
time_knots = make_knots(time_values,time_delta);
time_bases = make_bsplie_bases(time_values,time_knots);

% map
map = nan(width,height,size(time_bases,1),size(delay_bases,1));
sz = [width,height];
for x = 1:width
    for y = 1:height
        prb = sub2ind(sz,x,y);
        
        prb_map = load_map(session,channel,prb);
        
        sig_mean = mean(prb_map(:,:,1:bases_iterations),3);
        ctl_mean = mean(prb_map(:,:,bases_iterations + 1:bases_iterations + bases_iterations),3);
        sig_std = std(prb_map(:,:,bases_iterations + 1:bases_iterations + bases_iterations),[],3);
        map(x,y,:,:) = abs(sig_mean - ctl_mean) >= sigma .* sig_std;
    end
end
end
