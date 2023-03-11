function Sensors=disToSink(Sensors,Model)
    
    n=Model.n;
    for i=1:n
        
        distance=sqrt((Sensors(i).x-Sensors(n+1).x)^2 + ...
            (Sensors(i).yd-Sensors(n+1).yd)^2 );
        
        Sensors(i).dis2sink=distance;
        
    end
    
end