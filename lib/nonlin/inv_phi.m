function [y] = inv_phi(x,param)
% Inverse of scaled/biased logarithmic sigmoid: b - log((a / x) - 1)
y = param(2) - log((param(1) ./ x) - 1);
end
