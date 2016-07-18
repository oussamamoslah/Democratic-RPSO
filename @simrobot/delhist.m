function new = delhist(simrobot);
% DELHIST	(system) deletes "history" (replay data) from the simrobot object.

simrobot.history = [];

new = simrobot;
