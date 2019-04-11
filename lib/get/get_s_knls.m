function [stm,psk,off] = get_s_knls(session,channel,fold)
% Get kernels of specific s-model
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
% - stm: 4D array
%   (width x height x time x delay) stimulus kernel of s-model
% - psk: vector
%   (delay x 1) post-spike kernel of s-model
% - off: vector
%   (time x 1) offset kernel of s-model

model = load_model(session,channel,fold);

stm = model.set_of_kernels.stm.knl;

psk = model.set_of_kernels.psk.knl;
psk = psk(1,:);

off = model.set_of_kernels.off.knl;
end