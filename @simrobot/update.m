function [new,newmatrix,newrobots] = update(simrobot,matrix,robots)
% UPDATE	(system) updates the simulation.


if (simrobot.power) & (~simrobot.crashed)
   
   simrobot.velocity(1) = simrobot.velocity(1) + simrobot.accel(1);
   simrobot.velocity(2) = simrobot.velocity(2) + simrobot.accel(2);
   
   [xs ,ys ,rotspd] = mmodel(simrobot.velocity(1), simrobot.velocity(2), simrobot.heading);
   
	xd = get(simrobot.patch,'XData');
	yd = get(simrobot.patch,'YData');

	% ***** Remove robot from matrix *****
	drmex(round([xd';yd']),matrix,robots,simrobot.number);

	myrotate(simrobot.patch,[0 0 1],rotspd,[simrobot.position(1) simrobot.position(2) 0])
   
   % Old position 
	xpos = simrobot.position(1);											
	ypos = simrobot.position(2);
	% ***** Move robot and store data  *****
	simrobot.position(1) = simrobot.position(1) + xs;	% Update x
	simrobot.position(2) = simrobot.position(2) + ys;	% Update y
	simrobot.heading = simrobot.heading + rotspd;		% Update heading
   if simrobot.heading >= 360
      simrobot.heading = simrobot.heading - 360;
   end
   if simrobot.heading < 0
      simrobot.heading = 360 + simrobot.heading;
   end

	

	xd = get(simrobot.patch,'XData');
	yd = get(simrobot.patch,'YData');


	% Move patch to new location
	xd = xd - xpos;																
	yd = yd - ypos;	
	xd = simrobot.position(1) + xd;
	yd = simrobot.position(2) + yd;

	set(simrobot.patch,'XData',xd,'YData',yd)
   
	% ****** Place robot to matrix ******
   prmex(round([xd';yd']),matrix,robots,simrobot.number);

   
end

% This part is always done 


% We need to store robot's position
simrobot.history = [simrobot.history ; simrobot.position simrobot.heading];

newrobots = robots;
new = simrobot;
newmatrix = matrix;
