function Sensors = Sensing(Sensors, Model)
    for i=1:Model.n*Model.m     
        Sensors(i).E = Sensors(i).E - ...
            (Model.DataPacketSize * Model.Vsup * Model.Isens * Model.Tsens);
    end
            
end   
