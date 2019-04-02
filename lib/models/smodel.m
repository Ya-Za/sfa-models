function smodel(session,channel)
% State-variable generalized linear model framework
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number

fprintf('===== S-Model =====\n\n');
main_timer = tic();

% Select bases
method_timer = tic();
fprintf('----- Selct probes'' bases -----\n\n');
select_bases(session,channel);
toc(method_timer);

% Make profile
method_timer = tic();
fprintf('\n\n----- Make neural profile -----\n\n');
make_profile(session,channel);
toc(method_timer);

% Make model
method_timer = tic();
fprintf('\n\n----- Make neural model -----\n\n');
make_model(session,channel);
toc(method_timer);

% Make result
method_timer = tic();
fprintf('\n\n----- Make result -----\n\n');
make_result(session,channel);
toc(method_timer);

fprintf('\n\n');
toc(main_timer);
end