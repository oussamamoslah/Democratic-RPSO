function shape = getshape(simrobot);
% GETSHAPE	(system) returns shape data in a structure.
%		See also CHSHAPE.

xdata = simrobot.xdata;
ydata = simrobot.ydata;
shape = struct('xdata',xdata','ydata',ydata');
