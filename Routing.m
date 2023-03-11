function Sensors = Routing(Sensors, Model, D, r)

    global delayE delayD delayR lossE sentE lossD sentD lossR sentR pdr lossMat sentMat
    ql = 0.2;  
    for i=Model.m*Model.n+1:Model.n+Model.m*Model.n
        
        maxLayer = max([Sensors(:).Layer]);
        for j=1:2
            Sender = i;
            counter = 0;
            while (counter<maxLayer)
                Neighbours = Sensors(Sender).Neighbours;
                %Sender;
                %if isempty(Neighbours), break; end
                [~, idx] = max(Neighbours(:, 4));
                Receiver = Neighbours(idx, 1);
                distance = D(Sender, Receiver);
                dq = 0.001;
                dp = 0.005;
                delayR = delayR + dq + dp;
                while pdr(Sender-Model.m*Model.n, Receiver-Model.m*Model.n)+ql<rand()
                    Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                    lossR = lossR + 1;
                    sentR = sentR + 1;
                    delayR = delayR + distance/Model.C + Model.DataPacketSize/Model.TR;
                end
                Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                sentR = sentR + 1;
                delayR = delayR + distance/Model.C + Model.DataPacketSize/Model.TR;
                if Sensors(Sender).E == 0 || Sensors(Receiver).E == 0
                    lossR = lossR + 1;
                end
                lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                    lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + lossR;
                sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                    sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + sentR;
                if Receiver == Model.n+Model.m*Model.n+1
                    break;
                else
                    counter = counter+1;
                    Sender = Receiver;
                end
                
            end
        end
        
        
        if mod(r,2) == 0
            for j=1:2
                Sender = i;
                counter = 0;
                while (counter<maxLayer)
                    Neighbours = Sensors(Sender).Neighbours;
                    [~, idx] = max(Neighbours(:, 3));
                    Receiver = Neighbours(idx, 1);
                    distance = D(Sender, Receiver);
                    dq = 0.001;
                    dp = 0.005;
                    delayD = delayD + dq + dp;
                    while pdr(Sender-Model.m*Model.n, Receiver-Model.m*Model.n)+ql<rand()
                        Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                        lossD = lossD + 1;
                        sentD = sentD + 1;
                        delayD = delayD + distance/Model.C + Model.DataPacketSize/Model.TR;
                    end
                    Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                    sentD = sentD + 1;
                    delayD = delayD + distance/Model.C + Model.DataPacketSize/Model.TR;
                    if Sensors(Sender).E == 0 || Sensors(Receiver).E == 0
                        lossD = lossD + 1;
                    end
                    lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                        lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + lossD;
                    sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                        sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + sentD;
                    if Receiver == Model.n+Model.m*Model.n+1
                        break;
                    else
                        counter = counter+1;
                        Sender = Receiver;
                    end
                end
            end
        end
        
        if mod(r,5) == 0
            Sender = i;
            counter = 0;
            while (counter<maxLayer)
                Neighbours = Sensors(Sender).Neighbours;
                [~, idx] = max(Neighbours(:, 2));
                Receiver = Neighbours(idx, 1);
                distance = D(Sender, Receiver);
                dq = 0.001;
                dp = 0.005;
                delayE = delayE + dq + dp;
                %count = 0;
                while pdr(Sender-Model.m*Model.n, Receiver-Model.m*Model.n)+ql<rand() %&& count<2 
                    Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                    lossE = lossE + 1;
                    sentE = sentE + 1;
                    delayE = delayE + distance/Model.C + Model.DataPacketSize/Model.TR;
                    %count = count + 1 ;
                end
                
                Sensors = SendReceivePackets(Sensors, Model, Sender, 'Data', Receiver, distance);
                sentE = sentE + 1;
                delayE = delayE + distance/Model.C + Model.DataPacketSize/Model.TR;
                if Sensors(Sender).E == 0 || Sensors(Receiver).E == 0
                    lossE = lossE + 1;
                end
                lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                    lossMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + lossE;
                sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) = ...
                    sentMat(Sender-Model.m*Model.n, Receiver-Model.m*Model.n) + sentE;
                if Receiver == Model.n+Model.m*Model.n+1
                    break;
                else
                    counter = counter+1;
                    Sender = Receiver;
                end
            end
        end
    end
end
