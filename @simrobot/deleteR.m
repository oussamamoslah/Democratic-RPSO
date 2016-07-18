function deleteR(simrobot);
% DELETE(simrobot object) (system) deletes (visually) robot from the virtual environment.

set(simrobot.patch,'Visible','off');
h = findobj('Tag','EditorWindow');
matrix = get(h,'UserData');
xd = get(simrobot.patch,'XData');
yd = get(simrobot.patch,'YData');
drmex(round([xd';yd']),matrix,[],simrobot.number);
set(h,'UserData',matrix);