function [id] = get_id(session,channel)
id = sprintf('%d%02d',session,channel);
end