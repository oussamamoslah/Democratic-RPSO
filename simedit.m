function simedit;

h = findobj('Tag','EditorWindow');
delete(h);
h = findobj('Tag','SimWindow');
delete(h);
ssize = get(0,'ScreenSize');
figNumber = figure;
set(figNumber,	'Backingstore','off',...
    'CloseRequestfcn','simeditcb close',...
    'MenuBar','none',...
    'Position',[1 29 ssize(3) ssize(4)-66],...
    'NumberTitle','off',...
    'Name','Editor Window',...
    'RendererMode','manual',...
    'Renderer','Painters',...
    'Tag','EditorWindow','units','normalized',...
    'outerposition',[0 0 1 1]);
axis equal
axHndl=gca;
color = get(figNumber,'Color');

set(axHndl, ...
    'XLim',[0 200],'YLim',[0 200], ...
    'XDir','normal','YDir','normal', ...
    'Drawmode','fast', ...
    'Visible','on', ...
    'Tag','Axes',...
    'TickLength',[0 0],...
    'XColor',color,...
    'YColor',color);

h1 = uicontrol('Parent',figNumber, ...
    'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
    'FontName','Symbol', ...
    'FontSize',7, ...
    'ForegroundColor',[0.7 0.7 0.7], ...
    'ListboxTop',0, ...
    'Position',[ssize(3)-(220*ssize(3)/800) 6 10 10], ...
    'String','x', ...
    'Style','text', ...
    'Tag','Store');

h1 = uicontrol('Parent',figNumber, ...
    'Units','points', ...
    'BackgroundColor',[1 1 1], ...
    'FontName','Symbol', ...
    'FontSize',7, ...
    'ForegroundColor',[0.7 0.7 0.7], ...
    'HorizontalAlignment','center', ...
    'ListboxTop',0, ...
    'Position',[20 20 30 15], ...
    'Style','edit', ...
    'Tag','EditPath', ...
    'Visible','off');


h1 = uicontrol('Parent',figNumber, ...
    'Units','points', ...
    'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
    'FontName','Symbol', ...
    'FontSize',7, ...
    'ForegroundColor',[0.7 0.7 0.7], ...
    'ListboxTop',0, ...
    'Position',[20 20 51.75 21], ...
    'String','', ...
    'Style','text',...
    'Tag','ListStore', ...
    'Visible','off');




% ****** ContextMenu ******
uicm = uicontextmenu;
set(axHndl,'UIContextMenu',uicm);
uimenu(uicm,'Label','&Open simulation ..','Callback','simeditcb load');
uimenu(uicm,'Label','&Save simulation','Callback','simeditcb save','Tag','SaveMenu',...
    'Separator','on','Enable','off');
uimenu(uicm,'Label','Sa&ve simulation as ..','Callback','simeditcb saveas',...
    'Tag','SaveMenu','Enable','off');
params = uimenu(uicm,'Label','&Parameters','Enable','off','Separator','on');
uimenu('Parent',params,'Label','&Steps limit: Inf ','Tag','StepsMenu',...
    'Callback','simeditcb steps','Enable','off');
uimenu('Parent',params,'Label','Step &time: 0.001 ','Tag','DelayMenu',...
    'Callback','simeditcb delay','Enable','off');

uimenu(uicm,'Label','&Import Bitmap ..','Callback','simeditcb import','Separator','on');
uimenu(uicm,'Label','&Add new robot ..','Callback','simeditcb add','Separator','on','Enable','off');
uimenu(uicm,'Label','&Run','Callback','simeditcb run','Enable','off','Separator','on');
% ********************************

% ****** Window Menu ******
filemenu = uimenu('Label','&File');
uimenu('Parent',filemenu,'Label','&Open ..','Accelerator','O',...
    'Callback','simeditcb load');
uimenu('Parent',filemenu,'Label','&Save','Accelerator','S',...
    'Callback','simeditcb save','Tag','SaveMenu','Enable','off');
uimenu('Parent',filemenu,'Label','Sa&ve as..','Callback','simeditcb saveas',...
    'Tag','SaveMenu','Enable','off');
uimenu('Parent',filemenu,'Label','&Import bitmap ..','Accelerator','I',...
    'Callback','simeditcb import','Separator','on');
uimenu('Parent',filemenu,'Label','&Quit','Separator','on',...
    'Callback','simeditcb close','Accelerator','Q');

parmenu = uimenu('Label','&Parameters','Enable','off');
uimenu('Parent',parmenu,'Label','&Steps limit: Inf ','Tag','StepsMenu',...
    'Callback','simeditcb steps','Enable','off');
uimenu('Parent',parmenu,'Label','Step &time: 0.001 ','Tag','DelayMenu',...
    'Callback','simeditcb delay','Enable','off');

runmenu = uimenu('Label','&Run','Accelerator','R','Enable','off');
uimenu('Parent',runmenu,'Label','&Run','Accelerator','R','Callback','simeditcb run',...
    'Enable','off');

helpmenu = uimenu('Label','&About');
uimenu(	'Parent',helpmenu,'Label','&Help','Callback','simviewcb help',...
    'Enable','on','Accelerator','H');
uimenu(	'Parent',helpmenu,'Label','&About','Callback','simviewcb about',...
    'Enable','on','Accelerator','B');

% *************************