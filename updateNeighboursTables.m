function Sensors = updateNeighboursTables(Sensors, Model, D)
    global pdr;
    alpha = 1/2;
    for i=Model.m*Model.n+1:Model.n+Model.m*Model.n
        Temp = find(D(i,:)<Model.RR);
        Temp(Temp<Model.m*Model.n+1)=[];
        Neighbours = [];
        %Sensors(i).Neighbours = [];
        for j=1:length(Temp)
            if (Sensors(Temp(j)).Layer)+1 ==Sensors(i).Layer
                Neighbours =[Neighbours, Temp(j)];%#ok
            end
        end
        QValue = [];
        for j=1:length(Neighbours)
            %Q1 = alpha * Sensors(Neighbours(j)).E/Model.Ec + (1-alpha) / D(i, Neighbours(j));
            Q1 = alpha * Sensors(Neighbours(j)).E/Model.Ec + (1-alpha) * pdr((i-Model.m*Model.n), (Neighbours(j)-Model.m*Model.n)) / D(i, Neighbours(j));
            Q2 = alpha * Sensors(Neighbours(j)).E/Model.Ec + (1-alpha) * pdr((i-Model.m*Model.n), (Neighbours(j)-Model.m*Model.n));
            Q3 = alpha * pdr((i-Model.m*Model.n), Neighbours(j)-Model.m*Model.n) + (1-alpha) / (D(i, Neighbours(j))/Model.C) ;
            QValue = [QValue; Neighbours(j), Q1, Q2, Q3];%#ok
        end
        Sensors(i).Neighbours =  QValue ;
        
    end

end
