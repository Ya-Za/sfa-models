function [y] = dphi(x,param)
% Derivative of scaled/biased logarithmic sigmoid: a * s(x - b) (1 - s(x - b))
s = logsig(x - param(2));
y = param(1) .* s .* (1 - s);
end

