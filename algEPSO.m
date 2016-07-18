function [listout] = algEPSO(simrobot,list,matrix,step)


% your algorithm starts here

% only run the algorithm if it is a robot
if (strcmp(getnameR(simrobot),'PoI')==0) % if it is not a point of interest, then it is a robot

    % constant variables
    % Get number of robots
    Nrobots=0;
    jj=1;
    for j = 1:length(list)
        if (strcmp(getnameR(list(j)),'PoI')==0) % it is not a point of interest
            Nrobots=Nrobots+1;
            listAux(jj)=list(j);
            jj=jj+1;
        end
    end
    
    % Get robot ID
    robotid=0;
    for j = 1:length(listAux)
        if (getnum(simrobot)==getnum(listAux(j)))
            robotid=j;
        end
    end

     % RDPSO coefficients
    fract = 0.6;    % fractional coefficient
    pc=0.42;  %cognitive weight
    ps=0.42;  %social weight
    pobs=0.18;  %obstacle susceptibility weight
    pcomm=0.4;  %communication constraint weight
    
    % PSO coefficients
    fract = 0.6;    % fractional coefficient
    pc=0.42;  %cognitive weight
    ps=0.42;  %social weight

    % maximum communication range
    RangeComm = 300; % estava 300

    % runs only in first iteration
    if (step == 1)  % it will only enter this condition in the first iteration of all
        message.matrixout = ones(size(matrix));  
        [begin_angle, end_angle, n_of_rays, range] = getsensdata(simrobot,'sens1');
        % initialize first step of patrolling
        message.firststep = [];
        message.idleness = [];
        message.intentions = [];
        message.positions = [];
        message.beginning = [];
        message.decision = [];
        message.previous = [];
        message.current = [];
        message.next = [];
        message.idl_current=[];
        message.visited=zeros(15,1);
        % memorize previous velocities
        message.vx = 0;
        message.vx_t1 = 0;
        message.vx_t2 = 0;
        message.vx_t3 = 0;
        message.vy = 0;
        message.vy_t1 = 0;
        message.vy_t2 = 0;
        message.vy_t3 = 0;
        
        swarm = 1;

        message.swarm = swarm;
        % initialize best objective function so far as zero
        message.fMainBest = 0;
        message.gBestValue = 0;
        message.fObsBest = range;
        % initialize best cognitive, global and obstacle position as its own
        xyc = getpos(simrobot);
        message.xc = xyc(1);
        message.yc = xyc(2);
        message.xgBest = xyc(1);
        message.ygBest = xyc(2);

        % matrixout - mapping of matrix
        % save data to the memory of the robot
        simrobot = setdata(simrobot,getnum(simrobot)-1,message);
        % send data to teammates
        [ack,list] = exchangeData(simrobot,list,message,RangeComm,-1);
    else   % only run the algorithm after the first iteration of all robots so as to update the buffer
        %% check messages in the buffer of the robot
%         getnum(simrobot)-1
        buffer = getdata(simrobot);
        message = buffer{getnum(simrobot)-1};
        
        % update variables
        vx=message.vx;
        vx_t1=message.vx_t1;
        vx_t2=message.vx_t2;
        vx_t3=message.vx_t3;
        
        vy=message.vy;
        vy_t1=message.vy_t1;
        vy_t2=message.vy_t2;
        vy_t3=message.vy_t3;
           
        swarm=message.swarm;
         
        %% update best global solution and get collective map
                
        matrixin=ones(size(matrix));
        N=0;    % number of robots within the swarm
        
        % see if there is any information on buffer
        for i=1:length(buffer)
            if (isempty(buffer{i})==0)
                % update shared map - the map is shared with all robots
                matrixin = matrixin.*buffer{i}.matrixout;
                N=N+1;
                xswarm(N)=buffer{i}.xc;
                yswarm(N)=buffer{i}.yc;
                fswarm(N)=buffer{i}.fMainBest;
                numR(N)=i;
                %                 callrobotswarm[nrobots]=buffer[i+4];
                %                 createswarmswarm[nrobots]=buffer[i+5];
                %                 end
                % update the best solution of the whole swarm so far
                if (N>1)
                    distanceR=zeros(N,N);
                    angleR=zeros(N,N);

                    for (ii=1:N)

                        distanceR(N,ii)=sqrt((xswarm(N)-xswarm(ii))^2+(yswarm(N)-yswarm(ii))^2);
                        angleR(N,ii)=atan2((yswarm(ii)-yswarm(N)),(xswarm(ii)-xswarm(N)))*180/pi;
                        if (i==ii)
                            distanceR(N,ii)=NaN;
                        end
                        if (buffer{i}.fMainBest > message.gBestValue)
                            if (distanceR(N,ii)<RangeComm)
                                message.xgBest=buffer{i}.xc;
                                message.ygBest=buffer{i}.yc;
                                message.gBestValue = buffer{i}.fMainBest;
%                                         improve=1;  % swarm of this robot did improve
                            end
                        end

                    end
                 end
            end
        end
        
        xgBest = message.xgBest;
        ygBest = message.ygBest;

        
        %% update best cognitive solution, update and share map
        
        % read laser
        [dist,num] = readlaser(simrobot,'sens1',matrix);
                   
        % map the surroundings
        [message.matrixout, xyc, xFree, newcells] = mapping(simrobot,matrixin,dist,num,'sens1');

        % update the map with all the information acquired so far
        message.matrixout = message.matrixout.*matrixin;

        xy0 = getpos(simrobot);
        x0=xy0(1);
        y0=xy0(2);

        x1 = xyc(1);
        y1 = xyc(2);

        fMain = newcells;

        message.xc = x1;
        message.yc = y1;

        xc = message.xc;
        yc = message.yc;


            %% compute RDPSO equations
            Ix = fract*vx + (1.0/2.0)*fract*vx_t1 + (1.0/6.0)*fract*(1.0-fract)*vx_t2 + (1.0/24.0)*fract*(1.0-fract)*(2.0-fract)*vx_t3;
            Iy = fract*vy + (1.0/2.0)*fract*vy_t1 + (1.0/6.0)*fract*(1.0-fract)*vy_t2 + (1.0/24.0)*fract*(1.0-fract)*(2.0-fract)*vy_t3;
            
            Cx = pc*rand*(xc-x0);
            Cy = pc*rand*(yc-y0);

            Sx = ps*rand*(xgBest-x0);
            Sy = ps*rand*(ygBest-y0);

            vx = Ix + Cx + Sx;
            vy = Iy + Cy + Sy;
             
            % update previous velocities
            message.vx_t3=vx_t2;
            message.vx_t2=vx_t1;
            message.vx_t1=vx;
            
            message.vy_t3=vy_t2;
            message.vy_t2=vy_t1;
            message.vy_t1=vy;
            
            % new desired position
            x1=round(x0+vx);
            y1=round(y0+vy);
            
            % braitenberg obstacle ovoidance         
            x1 = xFree(1);
            y1 = xFree(2);
            
            distT = sqrt((x0-x1)^2+(y0-y1)^2);
            
            [begin_angle, end_angle, n_of_rays, range] = getsensdata(simrobot,'sens1');
            sensingRange=round(range/3);
            if (distT > sensingRange)
                x1=round(x0+vx);
                y1=round(y0+vy);
            end
            
            % call low level control function (update position)
            simrobot = LLC(simrobot,[x1 y1],dist);
            

        %% share data
        simrobot = setdata(simrobot,getnum(simrobot)-1,message);
        [ack,list] = exchangeData(simrobot,list,message,RangeComm,-1);  % send the new map to all robots
    
        % show map from 20 to 20 iterations (just for debug)
%         if (rem(step,20) == 0)
%             figure(2);
%             hold on;
% 
%             A=imrotate(not(message.matrixout),90);
%             imshow(A);
%             %     axis([0 xmax+1 0 ymax+1]);
%             drawnow;
%         end
    end
end

% end of your algorithm

list(getnum(simrobot)-1)=simrobot;
listout = list;

