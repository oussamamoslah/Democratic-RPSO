function shape = getsshape(simrobot);
% GETSSHAPE	(system) returns "scaled" shape.
%		See also GETSHAPE, CHSHAPE.

xdata = simrobot.xdata * simrobot.scale;
ydata = simrobot.ydata * simrobot.scale;

shape = struct('xdata',xdata,'ydata',ydata);
