function [dists,num] = readlaser(simrobot,sensname,matrix)
% READLASER		reads data from a laser scanner.
%			See also READUSONIC.

[tmp s] = size(simrobot.sensors);
i = 1;
while ((i < s) & (~strcmp(simrobot.sensors(i).name,sensname))),
   i = i + 1;
end

% The trasformation:
% x'=x*cos(alpha)-y*sin(alpha)
% y'=y*cos(alpha)+x*sin(aplha)
% where [x,y] is original point, [x' y'] is rotated point, alpha is rotation angle,
% origin of rotation is [0,0] (the pivot)

% Let's compute sine and cosine of heading beforehand, it's 2 times faster
sina = sin(simrobot.heading*pi/180);
cosa = cos(simrobot.heading*pi/180);

pos = simrobot.position + simrobot.scale*[simrobot.sensors(i).position(1)*cosa-simrobot.sensors(i).position(2)*sina simrobot.sensors(i).position(2)*cosa+simrobot.sensors(i).position(1)*sina];

[dists,num] = laser5(round(pos), matrix, [simrobot.heading + simrobot.sensors(i).axisangle - simrobot.sensors(i).scanangle/2 simrobot.heading + simrobot.sensors(i).axisangle + simrobot.sensors(i).scanangle/2 simrobot.sensors(i).resolution simrobot.sensors(i).range]);
