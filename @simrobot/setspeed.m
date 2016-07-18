function new = setspeed(simrobot,speed)

if length(speed) ~= 2 
   error('"Speed" must be a two-element vector ')
end   
simrobot.velocity = speed;

new = simrobot;