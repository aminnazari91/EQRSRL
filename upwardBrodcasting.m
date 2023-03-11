function Sensors = upwardBrodcasting(Sensors, Model, TrafficSenders, PacketType, D)
    %sendersID = 1:Model.n;           % All Sensors
    for s = TrafficSenders
        
        Sender = Sensors(s).id;
        Sensors = sendPacket(Sensors, Model, Sender, PacketType, D);
        visited = [Sender];
        Neighbours = findReceiver(Sender, D);             
        
        while (~isempty(Neighbours))
            n = Neighbours(1);
            Sensors = sendPacket(Sensors, Model, Sensors(n).id, PacketType, D);
            visited = [visited n];%#ok
            nn = findReceiver(Sensors(n).id, D);
            for i=1:length(nn)
                if ((isempty(find(Neighbours == nn(i), 1))) && (isempty(find(visited == nn(i), 1))))
                    Neighbours = [Neighbours, nn(i)];%#ok
                end
            end
            Neighbours(1) = [];
        end
    end
end
