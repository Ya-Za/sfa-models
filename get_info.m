function info = get_info()
    % Get global information
    %
    % Returns
    % -------
    % - info: struct
    %   - width: scaler
    %     Width of the probes' board
    %   - height: scaler
    %     Height of the probes' board
    %   - times: vector
    %     Saccade aligned study times
    %   - num_times: scalar
    %     Number of study times
    %   - num_delays: scalar
    %     Number of delays
    %   - probe_time_resolution: scaler
    %     Duration that a probe is on
    %   - num_folds: scalar
    %     Number of folds
    %   - folders: struct
    %       - assets: char vector
    %         Path to the `assets` folder
    %       - data: char vector
    %         Path to the `data` folder
    %       - bases: char vector
    %         Path to the `bases` folder
    %       - BS: char vector
    %         Path to the `BS` folder
    %       - profiles: char vector
    %         Path to the `profiles` folder
    %       - models: char vector
    %         Path to the `models` folder
    %       - results: char vector
    %         Path to the `results` folder
    
    width = 9;
    height = 9;
    times = -540:+540;
    num_times = length(times);
    num_delays = 150;
    probe_time_resolution = 7;
    num_folds = 1;
    
    assets_folder = 'assets';
    folders = struct(...
        'assets',assets_folder,...
        'data',fullfile(assets_folder,'data'),...
        'bases',fullfile(assets_folder,'bases'),...
        'BS',fullfile(assets_folder,'BS'),...
        'profiles',fullfile(assets_folder,'profiles'),...
        'models',fullfile(assets_folder,'models'),...
        'results',fullfile(assets_folder,'results'));
    
    info = struct(...
        'width',width,...
        'height',height,...
        'times',times,...
        'num_times',num_times,...
        'num_delays',num_delays,...
        'probe_time_resolution',probe_time_resolution,...
        'num_folds',num_folds,...
        'folders',folders);
end