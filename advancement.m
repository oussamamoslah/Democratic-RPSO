function [ Pourcentage ] = advancement( matrix )

% Map1 et 3: 819*460 = 376740 (9966:true and 366774:false ; 260969:accessible
% and 115771:not accessible) a verifier

% Map2 : 1174*464 = 544736 (28973:true and 5157663:false ; 383441:accessible
% and 161295:not accessible)

x=0;
for i = 1:1174
    for j = 1 :464
        if (matrix(i,j) ==0)
            x=x+1;
        end
    end
end
% Pourcentage = x/(260969)*100;
Pourcentage = x;
end

