function new = setcrashed(simrobot, newstate)

simrobot.crashed = newstate;
% set(simrobot.patch,'FaceColor',simrobot.color);
new = simrobot;