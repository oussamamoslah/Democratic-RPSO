function r = simrobot(name,number,heading,power,algfile,robot_color,...
   							robot_scale,robot_x_data,robot_y_data,robot_z_data)
% SIMROBOT		Contructor of 'simrobot' object

%	Please try to pass correct parameters, they are not (mostly) checked
%	It is assumed that the robot is heading east (=> need such data for patch definition)

if nargin == 0
   r.name = '';
   r.number = [];
   r.af = '';
   r.color = [];
   r.scale = [];
   r.patch = [];
   r.position = [];
   r.heading = [];
   r.velocity = [];
   r.accel = [];
   r.sensors = struct('name',[],'position',[],'axisangle',[],'scanangle',[],...
      					 'range',[],'resolution',[]);
   r.history = [];
   r.userdata = [];
   r.power = [];
   r.crashed = [];
   r.xdata = [];
   r.ydata = [];
   r.zdata = [];
   return
elseif isa(name,'simrobot')
   r = name;
	elseif nargin < 9
   error('Incomplete definition passed to simrobot constructor');
end
r.name = name;	
r.number = number;
r.af = algfile;							% Here store the path to control algorithm file
r.color = robot_color;
r.scale = robot_scale;   
   
% ******     Now define the shape of new robot    ******   
if nargin < 10
   robot_z_data = zeros(size(robot_x_data));			% No 3D data needed
end

if (size(robot_x_data) - size(robot_y_data) - size(robot_z_data)) ~= -size(robot_x_data)
   error('Please check patch data (xdata , ydata must have same dimensions)');
end																% A little bit strange data check
% ******************************************************

r.patch = patch(	'XData',robot_scale*robot_x_data, ...
				   	'YData',robot_scale*robot_y_data, ...
				   	'ZData',robot_scale*robot_z_data, ...
   					'FaceColor',robot_color, ...
				   	'EdgeColor','k', ...
				   	'tag',name, ...
				   	'EraseMode','xor');	% Define the patch
            
            
r.position = [0 0];							% Absolute position
r.heading = heading;							% In degrees, 0 = facing east [°]
r.velocity = [0 0];							% Speed of left and right wheel
r.accel = [0 0];								% Acceleration of left and right wheel
r.sensors = struct('name',[],'position',[],'axisangle',[],'scanangle',[],...
					    'range',[],'resolution',[]);
r.history = [];
r.userdata = [];							
r.power = power;								% Power switch is OFF
r.crashed = 0;
r.xdata = robot_x_data';
r.ydata = robot_y_data';
r.zdata = robot_z_data';

r = class(r, 'simrobot');				% Go !!
