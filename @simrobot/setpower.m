function new = setpower(simrobot, value)
% SIMROBOT = SETPOWER(SIMROBOT,VALUE)	sets the "power switch" 
% 					0 = robot is OFF , 1 = robot is ON 
%					accepts also 'on' & 'off'
%

if nargin > 1
   if ischar(value)
      switch lower(value)
      case 'on', value = 1;
      case 'off', value = 0;
      otherwise error('Robpower error: Unknown parameter');
      end
   end
   simrobot.power = value;
   new = simrobot;
else
   new = simrobot.power;
end

