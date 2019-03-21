function [file] = load_file(filename)
% Load data
%
% Parameters
% ----------
% - filename: char vaector
%   Filename which would be loaded


fprintf('Load `%s`: ',filename);

tic();
file = load(filename);
toc();
end
