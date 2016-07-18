function new = setdata(simrobot, nrobot, data);
% SETCOLOR	changes color of the robot.
%		See also GETCOLOR.

simrobot.userdata{nrobot} = [data];

new = simrobot;