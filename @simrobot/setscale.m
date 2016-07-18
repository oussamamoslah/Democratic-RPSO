function new = setscale(simrobot, newscale);
% SETSCALE 	(system) scales the robot (absolute scale). 
%		See also GETSCALE.	

if isstr(newscale)
   newscale = str2num(newscale);
end
%xdata = get(simrobot.patch,'XData');
%ydata = get(simrobot.patch,'YData');
position = simrobot.position;
%xdata = xdata - position(1);
%ydata = ydata - position(2);
set(simrobot.patch,'XData',position(1) + simrobot.xdata * newscale,...
   'YData',position(2) + simrobot.ydata * newscale)
myrotate(simrobot.patch,[0 0 1],simrobot.heading,[position(1) position(2) 0])
simrobot.scale = newscale;

new = simrobot;
