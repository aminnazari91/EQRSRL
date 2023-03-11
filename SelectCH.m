function [CH,Sensors]=SelectCH(Sensors,Model,fisCluster)
    
    CH=[];
    countCHs=0;
    n=Model.n;
    
    nMatrix=zeros(n);
    % generate neighbourhood matrix
    for i=1:n
        for j=1:n
            dis=sqrt((Sensors(i).xd-Sensors(j).xd)^2+...
                (Sensors(i).yd-Sensors(j).yd)^2);
            if dis<=Model.RR && i~=j && Sensors(i).E>0  && Sensors(j).E>0
                nMatrix(i,j)=1;
            end
        end
    end
    
%     distance=zeros(n,1);
%     for i=1:n
%             distance(i,j)=sqrt((Sensors(i).xd-Sensors(n+1).xd)^2+...
%                 (Sensors(i).yd-Sensors(n+1).yd)^2);
%     end
    
    numNeighbors=sum(nMatrix,2);
    
    fit=zeros(n,1);
    for i=1:1:n
        if(Sensors(i).E>0)          
            E=Sensors(i).E;
            nn=numNeighbors(i); 
            %disToSink=distance(i);
            disToSink=Sensors(i).dis2sink;
            fit(i)=evalfis([E nn disToSink],fisCluster);       
        end 
    end 
    
    [~,idx]=sort(fit,'descend');
    idx=idx(1:n*Model.p);
    for i=1:1:length(idx)
        
        if (Sensors(idx(i)).E>0)
            countCHs=countCHs+1; 
            CH=[CH, idx(i)]; %#ok 
            Sensors(idx(i)).type='C';
        end
    end
end
