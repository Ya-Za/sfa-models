function [map,delay_bases,time_bases] = decide_bases(session,channel,sigma)
% Decide about resolution of bases

num_iterations = 100;

info = get_info();
width = info.width;
height = info.height;
num_delays = info.num_delays;
num_times = info.num_times;
probe_time_resolution = info.probe_time_resolution;

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

% deciding about the map
map = nan(width,height,size(time_bases,1),size(delay_bases,1));
sz = [width,height];
for x = 1:width
    for y = 1:height
        prb = sub2ind(sz,x,y);
        
        prb_map = load_map(session,channel,prb);
        
        sig_mean = mean(prb_map(:,:,1:num_iterations),3);
        ctl_mean = mean(prb_map(:,:,num_iterations + 1:num_iterations + num_iterations),3);
        sig_stnd = std (prb_map(:,:,num_iterations + 1:num_iterations + num_iterations),[],3);
        map(x,y,:,:) = abs(sig_mean - ctl_mean) >= sigma .* sig_stnd;
    end
end
end
