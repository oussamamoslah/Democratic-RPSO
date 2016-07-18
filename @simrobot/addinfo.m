function new = addinfo(simrobot,uicm);
% ADDINFO	(system) adds uicontextmenu to the robot.
%		Used in Simulator.

uicm = uicontextmenu;
			uimenu(uicm,'Label','&Info','Callback','simrobcb info','UserData',simrobot.number);
			uimenu(uicm,'Label','&Edit algorithm ..','Callback','simrobcb algedit','UserData',...
            simrobot.number,'Separator','on');
item = 	uimenu(uicm,'Label','&Memory','Separator','on');     
			uimenu(uicm,'Parent',item,'Label','Memory &info','Callback','simrobcb showmem',...
	            'UserData',simrobot.number);
load = 	uimenu(uicm,'Parent',item,'Label','&Load from disk','UserData',simrobot.number);            
save = 	uimenu(uicm,'Parent',item,'Label','&Save to disk','UserData',simrobot.number);
			uimenu(uicm,'Parent',item,'Label','&Clear memory','Callback','simrobcb clearmem','UserData',...
         	   simrobot.number);
         
         uimenu(uicm,'Parent',save,'Label','&ASCII file','Callback','simrobcb saveasc','UserData',...
				   simrobot.number);   
         uimenu(uicm,'Parent',save,'Label','&MAT file','Callback','simrobcb savemat','UserData',...
				   simrobot.number);
            
         uimenu(uicm,'Parent',load,'Label','&ASCII file','Callback','simrobcb loadasc','UserData',...
				   simrobot.number);   
         uimenu(uicm,'Parent',load,'Label','&MAT file','Callback','simrobcb loadmat','UserData',...
				   simrobot.number);
            
set(uicm,'UserData',simrobot.number)
set(simrobot.patch,'UIContextMenu',uicm)

new = simrobot;
