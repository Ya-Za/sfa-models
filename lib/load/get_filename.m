function [filename] = get_filename(session,channel)
filename = [get_id(session,channel),'.mat'];
end