function Sensors = sendPacket(Sensors,Model,Sender, PacketType, D)
    
    global srp rrp sdp rdp dpl rpl
    sap = 0;                                % Sent a packet
    rap = 0;                                % Received a packet
    ploss = 0;                              % Packets loss
    if (strcmp(PacketType,'Hello'))
        PacketSize = Model.HelloPacketSize;
    else
        PacketSize = Model.DataPacketSize;
    end
    Receivers = findReceiver(Model, Sender, D);

    % Energy dissipated from Sender for sending a packet 
    distance = Model.RR;
    if (distance > Model.d0)
        Sensors(Sender).E = Sensors(Sender).E - (Model.ETX * PacketSize + Model.Emp * PacketSize * (distance ^ 4));              
    else
        Sensors(Sender).E = Sensors(Sender).E - (Model.ETX * PacketSize + Model.Efs * PacketSize * (distance ^ 2));
    end
    
    % Sensors(Sender).E = Sensors(Sender).E - ((PacketSize/Model.BitRate)*Model.Pt);
    % Sent a packet
    if(Sensors(Sender).E>0)
        sap = sap + 1;
        for i=1:length(Receivers)
            % Energy dissipated from sensors for receiveing a packet
            Receiver = Receivers(i);
            Sensors = receivePacket(Sensors ,Model, Receiver, PacketType);

            % Received a packet
            if (Sensors(Receiver).E>0)
                rap = rap + 1;
            else
                Sensors(Receiver).E = 0;
                ploss = ploss + 1;
            end
        end
    else
        Sensors(Sender).E = 0;
        ploss = ploss + 1;
    end
    
    if (strcmp(PacketType,'Hello'))
        srp = srp + sap;
        rrp = rrp + rap;
        rpl = rpl + ploss;
    else      
        sdp = sdp + sap;
        rdp = rdp + rap;
        dpl = dpl + ploss;
    end

end
