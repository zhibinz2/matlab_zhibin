function ph = ploty(x,y,varargin)
%PLOTY allows scrolling through columns of the input matrix.
%   H = PLOTY(...) accepts exactly same input arguments as PLOT, and
%   returns the handle of the lineseries in H; use directional (arrow) 
%   keys, or 'ASDW' to scroll through columns of input data;
%   Left: -1; Right: +1; Up: +10; Down: -10;
%
%   PLOTY(...,'AllColumn',true) plots all columns as background;
%
%   Example:
%       subplot(2,1,1); ploty(randn(100,30)); ylim([-2 1.5])
%       subplot(2,1,2); ploty(linspace(-1,1,100),randn(100,30));


% Siyi Deng; 04-06-2009; 10-02-2009;
if nargin < 2, y = []; end
if ischar(y) || isempty(y)
    varargin = [y,varargin{:},{}];
    y = x;
    x = 1:size(x,1);
end
[varargin,isAllColumn] = parsevar(varargin,'AllColumn',false);
if isempty(varargin)
    varargin = {};
end
if ~isnumeric(x), error('First input must be numeric.'); end

G = getappdata(gcf,'PlotyData');   

if isempty(G)
    G.Text = findobj(gcf,'Tag','PlotyText');
    if isempty(G.Text)
        G.Text = uicontrol(gcf,'Style','text','unit','norm','position',...
            [0.005 0.005 0.05 0.05],'string','1','Tag','PlotyText');
    end
    G.MaxColumn = size(y,2);    
    set(gcf,'KeyPressFcn',@FigKeyPressCall);
else
    G.MaxColumn = min(G.MaxColumn,size(y,2));
end

if toboolean(isAllColumn)
    hold on;
    nY = size(y,2);
    clr = colormap(lines(nY)).*0.1;
    for k = 1:nY;
        plot(x,y(:,k),'color',[.85 .85 .85]+clr(k,:));
    end
end
G.CurrentColumn = 1;
hold on;
ph = plot(x,y(:,1),'Tag','PlotyPlot',varargin{:});
hold off;
setappdata(ph,'PlotyY',y);
setappdata(gcf,'PlotyData',G);

end % PLOTCOL;

function FigKeyPressCall(src,Ev)
%key press callback;
G = getappdata(src,'PlotyData');
if strcmpi(Ev.Key,'rightarrow') || strcmpi(Ev.Key,'d')
    G.CurrentColumn = min(G.CurrentColumn+1,G.MaxColumn);
elseif strcmpi(Ev.Key,'leftarrow') || strcmpi(Ev.Key,'a')
    G.CurrentColumn = max(1,G.CurrentColumn-1);
elseif strcmpi(Ev.Key,'downarrow') || strcmpi(Ev.Key,'s')
    G.CurrentColumn = max(1,G.CurrentColumn-10);
elseif strcmpi(Ev.Key,'uparrow') || strcmpi(Ev.Key,'w')
    G.CurrentColumn = min(G.CurrentColumn+10,G.MaxColumn);
end
setappdata(src,'PlotyData',G);
ph = findobj(src,'type','line','Tag','PlotyPlot');
for k = 1:numel(ph)
    tmpY = getappdata(ph(k),'PlotyY');    
    set(ph(k),'ydata',tmpY(:,G.CurrentColumn));
end
set(findobj(src,'Tag','PlotyText'),'string',sprintf('%d',G.CurrentColumn));
end % FigKeyPressCall;



