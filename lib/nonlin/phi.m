function [y] = phi(x,param)
% scaled/biased logarithmic sigmoid: a * s(x - b)
y = param(1) .* logsig(x - param(2));
end

