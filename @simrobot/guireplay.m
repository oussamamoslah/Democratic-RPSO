function [newlist, newmatrix] = replay(list,matrix,step)
% GUIREPLAY	(system) executes one replay step.

e = length(list);									% How many robots do we have
%s = length(list(1).history);					% No. of records in history



   for j = 1:e
      
      simrobot = list(j);   					% Take robot from list
      hist = simrobot.history;				% This is for speeding up the animation
      pos = simrobot.position;
      
	   xpos = pos(1);								% Store actual position
		ypos = pos(2);

	   pos = hist(step,1:2);						% Take new position from history
   	rotspd = hist(step,3) - hist(step-1,3);	% Compute speed of rotation
         
		myrotate(simrobot.patch,[0 0 1],rotspd,[xpos ypos 0])	% Rotate robot

		xd = get(simrobot.patch,'XData');			
		yd = get(simrobot.patch,'YData');
		xd = xd - xpos;
		yd = yd - ypos	;	

		set(simrobot.patch,'XData',pos(1)+xd,'YData',pos(2)+yd)		% Update patch data
      
      simrobot.position = pos;						% Update simrobot's position
      list(j) = simrobot;								% Update list
      
   end

newlist = list;
newmatrix = matrix;