function new = sethist(simrobot,history);
% SETHIST	(system) gives new history to the robot. Strongly recommended not to change by the user.
%		See also GETHIST.

simrobot.history = history;

new = simrobot;
