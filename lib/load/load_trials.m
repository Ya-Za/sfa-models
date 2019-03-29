function [trials] = load_trials(session,channel)
% Load seperated trials for train/validation/test data sets 
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% 
% Returns
% -------
% - trials: struct (need more details)
%   Set of trials for train/validation/test data sets

info = get_info();

fullfilename = fullfile(...
    info.folders.data,...
    get_filename(session,channel));

file = load_file(fullfilename);
% N: number of trials
[N, ~] = size(file.stim);
conds = repmat((1:81)', ceil(N / 81), 1);
conds = conds(1:N);
trials = get_trials(conds);
end

function [trials] = get_trials(all_conds)
% Get trials
%
% Parameters
% ----------
% - all_conds: vector
%   All nonempty condition labels
%
% Returns
% -------
% - trials: struct
%   Trials for train/val/test data sets

info = get_info();
num_folds = info.num_folds;
pct_test = info.pct_test;
pct_train = info.pct_train;

all_indices = 1:numel(all_conds);

% test
unique_conds = unique(all_conds);
num_unique_conds = numel(unique_conds);
test_conds_idx = randperm(num_unique_conds,fix(num_unique_conds * pct_test));

[test_indices,test_conds] = make_correspond(unique_conds(test_conds_idx),all_conds,all_indices);

trials.test_indices(1).set = test_indices;
trials.test_conds(1).set = test_conds;

% train/validation
train_val_conds = unique_conds(setdiff(unique_conds,test_conds_idx));
pct_train = pct_train / (1 - pct_test);

for i = 1:num_folds
    % train
    train_conds_idx = randperm(numel(train_val_conds),fix(numel(train_val_conds) * pct_train));
    [train_indices,train_conds] = make_correspond(train_val_conds(train_conds_idx),all_conds,all_indices);
    trials.train_indices(i).set = train_indices;
    trials.train_conds(i).set = train_conds;
    
    % val
    val_conds_idx = setdiff(1:numel(train_val_conds),train_conds_idx);
    [val_indices,val_conds] = make_correspond(train_val_conds(val_conds_idx),all_conds,all_indices);
    trials.cross_indices(i).set = val_indices;
    trials.cross_conds(i).set = val_conds;
    
    
    if sum(abs(sort([trials.train_indices(i).set,trials.test_indices(1).set,trials.cross_indices(i).set])-all_indices)) ~= 0
        keyboard
    end
    if ...
            sum(diff(sort([trials.train_indices(i).set,trials.test_indices(1).set]))==0) ~= 0 || ...
            sum(diff(sort([trials.train_indices(i).set,trials.cross_indices(i).set]))==0) ~= 0 || ...
            sum(diff(sort([trials.test_indices(1).set,trials.cross_indices(i).set]))==0) ~= 0 || ...
            sum(diff(sort([unique(trials.train_conds(i).set),unique(trials.cross_conds(i).set)]))==0) ~= 0 || ...
            sum(diff(sort([unique(trials.train_conds(i).set),unique(trials.test_conds(1).set)]))==0) ~= 0 || ...
            sum(diff(sort([unique(trials.test_conds(1).set),unique(trials.cross_conds(i).set)]))==0)
        keyboard
    end
end
end

function [indices,conds] = make_correspond(some_conds,all_conds,all_indices)
conds = [];
indices = [];
for index = 1:numel(some_conds)
    c = some_conds(index);
    idx = (all_conds == c);
    conds = [conds,c * ones(1,sum(idx))];
    indices = [indices, all_indices(idx)];
end
end