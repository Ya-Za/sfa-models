function knl = get_a_knl_stm(session,channel)
% Get average of estimated stimulus kernels of specific a-model
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
% - knl: 4D array
%   (width x height x time x delay) stimulus kernel of s-model

model = load_avg_model(session,channel);
knl = model.set_of_kernels.gas.knl;
end