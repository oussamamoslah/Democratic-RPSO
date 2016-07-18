function [newlist,newmatrix] = runR(list,matrix,step)
%[NEWMLIST,NEWMATRIX] = RUN(LIST,MATRIX)	one step of the simulation
%
%LIST is a list of all robots in the simulation
%
%MATRIX is a matrix of the 'environment', 
%       which takes the simulation place in

dataFile = 'data_01';

robots = ones(1,length(list));

if step>1
    load(dataFile,'distanceDist','distanceCent','xtotalT','matrixin','visited','firststep');
end

jj=0;
matrixin=ones(size(matrix));

% Execute robots' algorithms
for j = 1:length(list)
   [list] = feval(list(j).af,list(j),list,matrix,step);	% Take robot from the list and execute algorithm
   [list(j),matrix,robots] = update(list(j),matrix,robots);	% Update robot
   if (strcmp(getnameR(list(j)),'PoI')==0) % if it is not a point of interest, then it is a robot
       jj=jj+1;
       xtotal(jj,1:2) = getpos(list(j));
       xtotalT(step,(1+2*(jj-1)):2+2*(jj-1))=xtotal(jj,1:2);
       buffer = getdata(list(j));
       message = buffer{getnum(list(j))-1};
       % update shared map - the map is shared with all robots
       matrixin = matrixin.*buffer{j}.matrixout;
%        if (isempty(buffer{j}.idleness)==0)
%            matrix_idle(:,jj) = buffer{j}.idleness;
%        else
%           matrix_idle(:,jj) = Inf*ones(15,1); 
%        end
       if (getnum(list(j))==2)
           visited = message.visited;
           firststep = message.firststep;
       end
   end
end

% matrix_idleT(step,1:3) = [mean(min(matrix_idle')') std(min(matrix_idle')') max(min(matrix_idle')')];

% central station -> x = 10; y = 100
for ii=1:jj
    for iii=1:jj
        distanceR(ii,iii)=((xtotal(ii,1)-xtotal(iii,1))^2+(xtotal(ii,2)-xtotal(iii,2))^2)^(1/2);
    end
end
distanceDist(step) = 0;
distanceCent(step) = 0;
for ii=1:jj
   distanceDist(step) = distanceDist(step) + max(distanceR(:,ii));
   distanceCent(step) = distanceCent(step) + 2*((xtotal(ii,1)-10)^2+(xtotal(ii,2)-100)^2)^(1/2);
end
% step
% distanceDist(step)
% distanceCent(step)
% 
% distanceDist
% distanceCent


save(dataFile,'distanceDist','distanceCent','xtotalT','matrixin','visited','firststep');
	
% Disable crashed robots
if ~all(robots)
   [temp, off] = find(~robots);
   for i = 1:length(off)
      list(off(i)).crashed = 1;
   end
end

% 'start'
% for j = 1:length(list)
%     getdata(list(j))
% end
if (rem(step,20) == 0) 
    [ Pourcent ] = advancement( matrixin );
    disp([num2str(Pourcent)]);
end
newlist = list;										% Return updated list
newmatrix = matrix;									% Return updated matrix