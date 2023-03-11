function Sensors=ConfigureSensors(Model,n,GX,GY)
%% Configuration EmptySensor
EmptySensor.x=0;
EmptySensor.y=0;
EmptySensor.df=0;
EmptySensor.type='Null';
EmptySensor.E=0; 
EmptySensor.id=0;
EmptySensor.dis2sink=0;
EmptySensor.dis2corr=0;
EmptySensor.MoC=0;    %Member of coordinator
EmptySensor.SensingFreq = 0;  
EmptySensor.PowerConsumption = 0;      
EmptySensor.TransferingRate = 0;

%% Configuration Sensors
Sensors=repmat(EmptySensor,n+1+Model.m*n,1);

for i=Model.m*n+1:1:n+Model.m*n
    %set x location
    Sensors(i).x=GX(i-Model.m*n); 
    %set y location
    Sensors(i).y=GY(i-Model.m*n);
    %dead flag. Whether dead or alive S(i).df=0 alive. S(i).df=1 dead.
    Sensors(i).df=0; 
    %initially there are not each cluster heads 
    Sensors(i).type='C';
    %initially all nodes have equal Energy
    Sensors(i).E=Model.Ec;
    %id
    Sensors(i).id=i;
    Sensors(i).Layer=inf;
    Sensors(i).Neighbours = [];
end 

Sensors(n+Model.m*n+1).x=Model.Sinkx; 
Sensors(n+Model.m*n+1).y=Model.Sinky;
Sensors(n+Model.m*n+1).E=1000;
Sensors(n+Model.m*n+1).id=n+Model.m*n+1;
Sensors(n+Model.m*n+1).Layer=0;
Sensors(n+Model.m*n+1).type='C';

for i=1:Model.m*n
    %set x location
    idx = ceil(i/Model.m);
    Sensors(i).x=GX(idx)+rand(); 
    %set y location
    Sensors(i).y=GY(idx)+rand();
    %dead flag. Whether dead or alive S(i).df=0 alive. S(i).df=1 dead.
    Sensors(i).df=0; 
    %initially there are not each cluster heads 
    Sensors(i).type='N';
    %initially all nodes have equal Energy
    Sensors(i).E=Model.En;
    %id
    Sensors(i).id=i;
    Sensors(i).MoC = idx+Model.m*n;
    counterType = mod(i,5);
    if (counterType == 0)
        Sensors(i).type = 'ecg';
        Sensors(i).E = 3.3 ;  
        Sensors(i).SensingFreq = 500;  
        Sensors(i).PowerConsumption = 464 * 10^-3;
        Sensors(i).TransferingRate = 1;

    elseif (counterType == 1)
        Sensors(i).type = 'o2';
        Sensors(i).E = 3.3 ;
        Sensors(i).SensingFreq = 500 ; 
        Sensors(i).PowerConsumption = 464 * 10^-3;
        Sensors(i).TransferingRate = 1;

    elseif (counterType == 2)
        Sensors(i).type = 'eeg';
        Sensors(i).E = 5.5 ;
        Sensors(i).SensingFreq = 20; 
        Sensors(i).PowerConsumption = 435 * 10^-3;
        Sensors(i).TransferingRate = 2;

    elseif (counterType == 3)
        Sensors(i).type = 'blood';
        Sensors(i).E = 5 ;
        Sensors(i).SensingFreq = 4 ; 
        Sensors(i).PowerConsumption = 464 * 10^-3;       
        Sensors(i).TransferingRate = 2;

    else %(counterType == 4):
        Sensors(i).type = 'temp';
        Sensors(i).E = 3.3 ;
        Sensors(i).SensingFreq = 0.2 ;  
        Sensors(i).PowerConsumption = 1951 * 10^-3 ;     
        Sensors(i).TransferingRate = 5;
    end
end


end