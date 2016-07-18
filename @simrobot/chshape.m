function new = chshape(simrobot,new_x_data,new_y_data,new_z_data)
% CHSHAPE	(system) changes shape of the robot.
%		See also GETSHAPE.

if nargin == 0
   % Nothing to do
   return
end   
if size(new_x_data) ~= size(new_y_data)
   error('Please check patch data (xdata & ydata must have same dimensions)');
end

if nargin < 4
   new_z_data = zeros(size(new_x_data));			% No 3D data needed
end

set(simrobot.patch,'XData',new_x_data * simrobot.scale + simrobot.position(1))
simrobot.xdata = new_x_data';
set(simrobot.patch,'YData',new_y_data * simrobot.scale + simrobot.position(2))
simrobot.ydata = new_y_data';
set(simrobot.patch,'ZData',new_z_data * simrobot.scale)
simrobot.zdata = new_z_data';
myrotate(simrobot.patch,[0 0 1],simrobot.heading,[simrobot.position(1) simrobot.position(2) 0])

new = simrobot;   