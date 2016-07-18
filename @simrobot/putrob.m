function new = putrob(simrobot,position,matrix);
% PUTROB	(system) Puts the robot into matrix, at given location.
% 		Takes robot's heading from the robot's object.
%		See also DELETE.


% If patch doesn't exit, redefine it (this is necessary after loading)
try 
   get(simrobot.patch,'Type');
   catch
	simrobot.patch = patch(	'XData',simrobot.scale * simrobot.xdata + position(1), ...
					   			'YData',simrobot.scale * simrobot.ydata + position(2), ...
							   	'ZData',simrobot.scale * simrobot.zdata, ...
   								'FaceColor',simrobot.color, ...
							   	'EdgeColor','k', ...
							   	'Tag',simrobot.name, ...
                           'EraseMode','xor',...
                           'Visible','on');	% Define the patch
end

% ******	Select position and heading (rotate) ******
% ****** Set zero position *******
set(simrobot.patch,'XData',simrobot.scale * simrobot.xdata + simrobot.position(1), ...
   'YData',simrobot.scale * simrobot.ydata + simrobot.position(2));
% ********************************
myrotate(simrobot.patch,[0 0 1],simrobot.heading,[simrobot.position(1) simrobot.position(2) 0])
% **************************************************
% ****** Get patch data in position [0 0] *******
xd = get(simrobot.patch,'XData') - simrobot.position(1);
yd = get(simrobot.patch,'YData') - simrobot.position(2);
% ***********************************************
simrobot.position = position;
set(simrobot.patch,'XData',simrobot.position(1) + xd,'YData',simrobot.position(2) + yd)
% ***************************************************
set(simrobot.patch,'Visible','on')

% ****** Create ContextMenu ******
uicm = uicontextmenu;
set(simrobot.patch,'UIContextMenu',uicm);
item0 = uimenu(uicm,'Label','&Info','Callback','simrobcb info','UserData',simrobot.number);
item1 = uimenu(uicm,'Label','&Name ..','Callback','simrobcb name','UserData',simrobot.number,'Separator','on');
item2 = uimenu(uicm,'Label','&Power ..','Callback','simrobcb power','UserData',simrobot.number);
item3 = uimenu(uicm,'Label','&Move','Callback','simrobcb move','UserData',simrobot.number,'Separator','on');
item4 = uimenu(uicm,'Label','&Heading ..','Callback','simrobcb heading','UserData',simrobot.number);
item5 = uimenu(uicm,'Label','&Delete','Callback','simrobcb delete','UserData',simrobot.number);
item6 = uimenu(uicm,'Label','S&ensors ..','Callback','simrobcb sensors','UserData',simrobot.number,'Separator','on');
item7 = uimenu(uicm,'Label','Appea&rance ..','Callback','','UserData',simrobot.number,'Separator','on');
	item71 = uimenu(item7,'Label','&Color ..','Callback','simrobcb chcol','UserData',simrobot.number);
	item72 = uimenu(item7,'Label','&Scale ..','Callback','simrobcb chscale','UserData',simrobot.number);
	item73 = uimenu(item7,'Label','Sh&ape ...','Callback','simrobcb chshape','UserData',simrobot.number);
item8 = uimenu(uicm,'Label','&Algorithm','Callback','','UserData',simrobot.number,'Separator','on');
	item81 = uimenu(item8,'Label','&Edit ...','Callback','simrobcb algedit','UserData',simrobot.number);
	item82 = uimenu(item8,'Label','&Assign ...','Callback','simrobcb algassign','UserData',simrobot.number);
	item83 = uimenu(item8,'Label','&New ...','Callback','simrobcb algnew','UserData',simrobot.number);

set(uicm,'UserData',simrobot.number);
% ********************************

if prmex(round([xd'+simrobot.position(1);yd'+simrobot.position(2)]),matrix,-1,simrobot.number) == -1
	% This section is executed on robot-placing error   
end


if isempty(simrobot.history)					% 'putrob' is also used for robots with history -
   simrobot.history = [simrobot.position simrobot.heading];		% then we don't want to 
end																				% change this field


new = simrobot;

