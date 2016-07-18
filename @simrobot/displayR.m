function displayR(simrobot)
% DISPLAY	(system) overloaded method for displaying some robot properties.

[null i] = size(simrobot);
for j = 1:i
disp(' ')
dispstr=strcat('		Name      : ',simrobot(j).name);
disp(dispstr)	
if ~isa(simrobot(j).color,'string')
   dispstr = num2str(simrobot(j).color);
end
dispstr=strcat('		Color     : ',dispstr);
disp(dispstr)
dispstr=strcat('		Algorithm : ',simrobot(j).af);
disp(dispstr)
dispstr=strcat('		Number    : ',num2str(simrobot(j).number));
disp(dispstr)
end

clear null i j dispstr					% Cleanup