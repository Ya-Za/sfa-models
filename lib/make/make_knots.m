function knots = make_knots(values,delta)
% Make knots

half_delta = fix(delta / 2);
delta = 2 * half_delta;

knots = ...
    min(values) - delta:...
    half_delta:...
    max(values) + delta;
end