function stim = code2stim(stimcode)
% Convert stimcode to stim
%
% Parameters
% ----------
% - stimcode: integer matrix(trial,time)
%   Coded stimuli
%
% Returns
% -------
% - stim: boolean array(trial,width,height,time)
%   Stimulus

info = get_info();
width = info.width;
height = info.height;

% N: Number of trials
% T: Number of times
[N,T] = size(stimcode); % trial x time

stim = zeros(N,width,height,T);

sz = [width,height];
for trial = 1:N
    end_time = find(~isnan(stimcode(trial,:)),1,'last');
    
    for time = 1:end_time
        index = stimcode(trial,time);
        
        if index
            [x,y] = ind2sub(sz,index);
            stim(trial,x,y,time) = 1;
        end
    end
    
    stim(trial,:,:,(end_time + 1):end) = nan;
end

end
