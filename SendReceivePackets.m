function Sensors=SendReceivePackets(Sensors,Model,Sender,PacketType,Receiver, distance)
    
   global srp rrp sdp rdp 
   sap=0;      % Send a packet
   rap=0;      % Receive a packet
   if (strcmp(PacketType,'Hello'))
       PacketSize=Model.HelloPacketSize;
   else
       PacketSize=Model.DataPacketSize;
   end
   
   %Energy dissipated from Sensors for Send a packet 
   if (distance > Model.d0)
        Sensors(Sender).E = Sensors(Sender).E - (Model.ETX * PacketSize + Model.Emp * PacketSize * (distance ^ 4));              
   else
        Sensors(Sender).E = Sensors(Sender).E - (Model.ETX * PacketSize + Model.Efs * PacketSize * (distance ^ 2));
   end
      
   if (Sensors(Sender).E <0 ), Sensors(Sender).E = 0; end
   
   %Energy dissipated from sensors for Receive a packet
   for j=1:length( Receiver)
        Sensors(Receiver(j)).E =Sensors(Receiver(j)).E- ...
            ((Model.ERX + Model.EDA)*PacketSize *length(Sender));
   end   
   
   
   for j=1:length(Receiver)

        %Received a Packet
        if(Sensors(Sender).E>0 && Sensors(Receiver(j)).E>0)
            rap=rap+1;
        end

        if (Sensors(Receiver(j)).E < 0), Sensors(Receiver(j)).E = 0; end
   end 
   
   
    if (strcmp(PacketType,'Hello'))
        srp=srp+sap;
        rrp=rrp+rap;
    else       
        sdp=sdp+sap;
        rdp=rdp+rap;
    end
   
end

  
