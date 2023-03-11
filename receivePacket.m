function Sensors = receivePacket(Sensors ,Model, Receiver, PacketType)
    if (strcmp(PacketType,'Hello'))
        PacketSize = Model.HelloPacketSize;
    else
        PacketSize = Model.DataPacketSize;
    end
    
    %Energy dissipated from sensors for Receive a packet    
    Sensors(Receiver).E = Sensors(Receiver).E - (Model.ERX * PacketSize);
    %Sensors(Receiver).E = Sensors(Receiver).E - ((PacketSize/Model.BitRate)*(Model.Pr));
end
