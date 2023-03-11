function Sensors = SendCoordinators(Sensors, Model, r)

    for i=1:Model.n*Model.m 
        if (mod(r, Sensors(i).TransferingRate) == 0)
            Sender = i;
            Receiver = ceil(i/Model.m);
            Receiver = Model.m*Model.n + Receiver;
            Sensors=SendReceivePackets(Sensors,Model,Sender,'Data', Receiver, Model.inRR);
        end
    end

end
