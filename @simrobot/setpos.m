function new = setpos(simrobot, position)
% SETPOS	(system) set the robot to the new position.
%		See also GETPOS.

simrobot.position = position;

new = simrobot;