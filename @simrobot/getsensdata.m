function [begin_angle, end_angle, n_of_rays, range] = getsensdata(simrobot,sensname);
% GETSENS	(system) returns sensors structure.
%		See also ADDSENS, ADDSENSS.

[tmp s] = size(simrobot.sensors);
i = 1;
while ((i < s) & (~strcmp(simrobot.sensors(i).name,sensname))),
   i = i + 1;
end

begin_angle = simrobot.heading + simrobot.sensors(i).axisangle - simrobot.sensors(i).scanangle/2;
end_angle = simrobot.heading + simrobot.sensors(i).axisangle + simrobot.sensors(i).scanangle/2;
n_of_rays = simrobot.sensors(i).resolution;
range = simrobot.sensors(i).range;