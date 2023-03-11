function Sensors = updateNeighbours(Sensors, Model, mobileNodes, D)

    for i=1:length(mobileNodes)
        Sender = mobileNodes(i);
        Sensors = sendPacket(Sensors, Model, Sender, 'Hello', D);
    end


end
