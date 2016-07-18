function new = setcolor(simrobot, newcolor);
% SETCOLOR	changes color of the robot.
%		See also GETCOLOR.

simrobot.color = newcolor;
set(simrobot.patch,'FaceColor',simrobot.color);
new = simrobot;