function Sensors = Scheduling(Sensors, Model)

    for i=Model.n*Model.m+1:Model.n*Model.m+Model.n
        
        Members = find([Sensors(:).MoC] == i);
        
        Sensors=SendReceivePackets(Sensors,Model,i,'Hello',Members, Model.inRR);
    end
end
