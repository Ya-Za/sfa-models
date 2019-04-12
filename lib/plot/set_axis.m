function set_axis()
% Set sompe properties of current axis

box('on');
grid('on');
colormap('jet');
set(gca(),'FontSize',20);
axis('tight');
end