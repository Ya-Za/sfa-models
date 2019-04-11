function knl = get_f_knl_stm(session,channel,fold)
% Get estimated stimulus kernel of specific f-model
%
% Parameters
% ----------
% - session: scalar
%   Session number with format: yyyymmdd
% - channel: scalar
%   Channel number
% - fold: integer scalar
%   Fold number
%
% Returns
% -------
% - knl: 4D array
%   (width x height x time x delay) stimulus kernel of s-model

model = load_model(session,channel,fold);
knl = model.set_of_kernels.gas.knl;
end