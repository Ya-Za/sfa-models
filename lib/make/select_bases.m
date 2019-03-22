function [] = select_bases(session,channel)
% Select bases
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number

num_iterations = 100; % for each `true` and `shuffle`

info = get_info();
times = info.times;
bases_folder = info.folders.bases;

% create neural profile
% todo:
% - `range_of_study` -> `time`
% - `set_of_data` -> `data`
% - `set_of_basis` -> `bases`
% - `set_of_trials` -> `trials`
profile = struct(...
    'session',session,...
    'channel',channel,...
    'range_of_study',times,...
    'set_of_data',load_data(session,channel),...
    'set_of_basis',make_bases(),...
    'set_of_trials',make_trials(session,channel));

% set of parameters
profile.set_of_params = make_params(...
    profile.set_of_data.RESP,...
    profile.set_of_data.stimcode);

% building maps
id = get_id(session,channel);
bases_subfolder = fullfile(bases_folder,id);
if ~exist(bases_subfolder,'dir')
    mkdir(bases_subfolder);
end

[~,width,height,~] = size(profile.set_of_data.STIM);
sz = [width,height];
for x = 1:width
    for y = 1:height
        index = sub2ind(sz,x,y);
        
        % todo: `map_1` -> `map1`
        map_filename = fullfile(bases_subfolder,sprintf('prb%02d.mat',index));
        if ~exist(map_filename,'file')
            save_timer = tic();
            
            map = make_map(...
                x,...
                y,...
                profile.set_of_data.STIM,...
                profile.set_of_data.RESP,...
                profile.set_of_data.tsaccade,...
                profile.range_of_study,...
                profile.set_of_params,...
                profile.set_of_basis.B_d,...
                profile.set_of_basis.B_t,...
                profile.set_of_trials,...
                num_iterations);
            
            fprintf('Save `%s`: ',map_filename);
            save(map_filename,'map');
            toc(save_timer);
        end
        
    end
end
end

function [bases] = make_bases()
% Make bases

info = get_info();
num_delays = info.num_delays;
num_times = info.num_times;
probe_time_resolution = info.probe_time_resolution;

% stimulus bases
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

% todo:
% - `B_d` -> `delay`
% - `B_t` -> `time`
bases = struct(...
    'B_d',delay_bases,...
    'B_t',time_bases);
end

function trials = make_trials(session,channel)
% Make trials and their conditions

set_of_trials = load_trials(session,channel);

% todo:
% - `set_of_trials` -> `trials`
% - `cross_indices` -> `val_indices`
% - remove `set` field
% - why just use `1` index
trials.trials = [
    set_of_trials.train_indices(1).set,...
    set_of_trials.cross_indices(1).set,...
    set_of_trials.test_indices(1).set];

% todo:
% `condtn` -> `conditions`
trials.condtn = [
    set_of_trials.train_conds(1).set,...
    set_of_trials.cross_conds(1).set,...
    set_of_trials.test_conds(1).set];
end

function params = make_params(resp,stimcode)
% Make parameters

% todo: 0 -> b0
params.params = [1000 0];

resp = resp(~isnan(stimcode));
params.b0 = inv_phi(...
    mean(resp) * 1000,...
    params.params);
end

function [map] = make_map(...
    x,...
    y,...
    stim,...
    resp,...
    tsaccade,...
    times,...
    params,...
    delay_bases,...
    time_bases,...
    trials,...
    num_iterations)
% Make mape for a given probe

% todo: use `nProfile` instead of so many input parameters

num_trials = size(stim,1); % number of trials
num_times = length(times); % number of times
num_delay_bases = size(delay_bases,1); % number of bases for delay
num_time_bases = size(time_bases,1); % number of bases for time

% make BS
% todo: need more explantions
BS = nan(num_delay_bases,num_trials,num_times);

for i = 1:num_trials
    part_of_stim = squeeze(stim(i,x,y,:));
    nan_index = find(isnan(part_of_stim),1);
    part_of_stim = part_of_stim(1:nan_index - 1);
    
    for j = 1:num_delay_bases
        t_conv = conv(delay_bases(j,:),part_of_stim);
        BS(j,i,:) = t_conv(tsaccade(i) + times);
    end
end

% make rsp
num_trials = size(resp,1); % number of trials

rsp = nan(num_trials,num_times);

for i = 1:num_trials
    rsp(i,:) = resp(i,tsaccade(i) + times);
end

% make the map
map = nan(num_time_bases,num_delay_bases,num_iterations+num_iterations);
for i = 1:num_time_bases
    x = nan(num_delay_bases,num_iterations + num_iterations);
    idx = time_bases(i,:) > 0;
    
    for j = 1:num_iterations
        [train_indices,val_indices] = make_train_val(...
            trials.trials,...
            trials.condtn,...
            0.35,...
            0.30);
        
        x(:,j) = fit_model(...
            BS(:,:,idx),...
            rsp(:,idx),...
            params,...
            train_indices,...
            val_indices,...
            0);
    end
    
    for j = num_iterations + 1:num_iterations + num_iterations
        [train_indices,val_indices] = make_train_val(...
            trials.trials,...
            trials.condtn,...
            0.35,...
            0.30);
        
        x(:,j) = fit_model(...
            BS(:,:,idx),...
            rsp(:,idx),...
            params,...
            train_indices,...
            val_indices,...
            1);
    end
    
    map(i,:,:) = x;
end
end

function [train_indices,val_indices] = make_train_val(trials,conditions,train_percent,val_percent)
% Make train and validation indeces

unique_conditions = unique(conditions);
train_idx = randperm(length(unique_conditions),fix(length(unique_conditions) * train_percent));
reste_idx = setdiff(1:length(unique_conditions),train_idx);
val_idx = reste_idx(randperm(length(reste_idx),fix(length(reste_idx) * val_percent / (1 - train_percent))));

% train
train_indices = [];
for index = 1:length(train_idx)
    train_indices = [
        train_indices,...
        trials(conditions == unique_conditions(train_idx(index)))
        ];
end

% validtation
val_indices = [];
for index = 1:length(val_idx)
    val_indices = [
        val_indices,...
        trials(conditions == unique_conditions(val_idx(index)))
        ];
end

if ~isempty(intersect(train_indices,val_indices)) || ~isempty(intersect(train_idx,val_idx))
    keyboard
end

end

function [x] = fit_model(BS,resp,params,trn_indices,crs_indices,rnd_flag)
% Fit model

learning_rate = 1e-2; % learning rate
improvement = inf;
x = zeros(size(BS,1),1)+1e-6;
if rnd_flag == 1
    resp = resp(randperm(size(resp,1)),:);
end
while improvement > 1e-2 && learning_rate > 1e-8
    % before
    % - train
    train_before = loglike(trn_indices,x,BS,resp,params);
    % - validataion
    val_before = loglike(crs_indices,x,BS,resp,params);
    
    % update `x`
    train_grad = grad_comp(trn_indices,x,BS,resp,params);
    new_x = x + learning_rate.*train_grad;
    
    % after
    % - train
    train_after = loglike(trn_indices,new_x,BS,resp,params);
    % - validation
    val_after = loglike(crs_indices,new_x,BS,resp,params);
    
    if ...
            train_after <= train_before ||...
            val_after <= val_before ||...
            isnan(train_after) ||...
            isnan(val_after)
        learning_rate = learning_rate / 10;
    else
        improvement = norm(new_x - x) ./ (norm(x) + eps);
        x = new_x;
    end
end
end

function [grd] = grad_comp(indices,x,BS,rsp,set_of_params)
% Devivative of components

delta = 1/1000;
BS = BS(:,indices,:);
rsp = rsp(indices,:);
b0 = set_of_params.b0;
params = set_of_params.params;
inside_phi = squeeze(sum(x .* BS,1));
lmd = phi(inside_phi + b0,params);
BS2d = reshape(BS,[size(BS,1),size(BS,2) * size(BS,3)]);
ld2d = ones(size(BS,1),1) * reshape(lmd,[1,size(BS,2) * size(BS,3)]);
rs2d = ones(size(BS,1),1) * reshape(rsp,[1,size(BS,2) * size(BS,3)]);
grd = sum(((rs2d./ld2d)-delta) .* dphi(inv_phi(ld2d,params),params) .* (BS2d) , 2);
end

function [out] = loglike(indices,x,BS,resp,params)
% Log-likelihood

delta = 1/1000;
BS = BS(:,indices,:);
resp = resp(indices,:);
b0 = params.b0;
params = params.params;
inside_phi = squeeze(sum(x .* BS,1));
lmd = phi(inside_phi + b0,params);
ll_over_trials = resp .* log((lmd + eps) * delta) - ((lmd + eps) * delta);
out = sum(sum(ll_over_trials));
end