function new = setaccel(simrobot,accel)
% SETACCEL	sets acceleration of left and right wheel.
%		See also GETACCEL.

if length(accel) ~= 2 
   error('"Accel" must be a two-element vector ')
end   
simrobot.accel = accel;

new = simrobot;