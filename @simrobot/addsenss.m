function new = addsenss(simrobot,data)
% ADDSENSS	(system) Adds new sensor into simrobot object.
%		Sensor data (input data) are stored in a structured variable.
%		This method is used in GUI-version of the toolbox.
%		See also ADDSENS.


% DATA is input structure with sensor data


% ******* Clear sensor structure *******
simrobot.sensors = struct('name',[],'position',[],'axisangle',[],'scanangle',[],...
      					 'range',[],'resolution',[]);
% **************************************                   
                   
for s = 1:length(data)
simrobot.sensors(s).name = data(s).name;
simrobot.sensors(s).position = data(s).position;
simrobot.sensors(s).axisangle = data(s).axisangle;
simrobot.sensors(s).scanangle = data(s).scanangle;
simrobot.sensors(s).range = data(s).range;
simrobot.sensors(s).resolution = data(s).resolution;
end

new = simrobot;