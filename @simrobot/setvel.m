function new = setvel(simrobot,vel)
% SETVEL	sets angular velocities of left and right wheel.
%		See also GETVEL, GETACCEL, SETACCEL.

if length(vel) ~= 2 
   error('"Vel" must be a two-element vector ')
end   
simrobot.velocity = vel;

new = simrobot;