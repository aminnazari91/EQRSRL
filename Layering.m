function Sensors = Layering(Sensors, Model, D)

    n = Model.n;
    m = Model.m;
    
    flag = zeros(1,n);
    count = 0;
    while (sum(flag)<n && count<10)
        count = count +1 ;
        for i=n*m+1:n+n*m
            NeighbourList = find(D(i, :)~=inf) ;
            NeighbourList(NeighbourList<n*m+1) = [];
            minNeighbourLayer = inf;
            for j=1:length(NeighbourList)    
                if  Sensors(NeighbourList(j)).Layer<minNeighbourLayer
                    minNeighbourLayer = Sensors(NeighbourList(j)).Layer;
                end 
            end
            if (minNeighbourLayer~=inf)
                Sensors(i).Layer = minNeighbourLayer+1;

                flag(i) = 1;
            end
            %flag
        end
    end
end
