clc;
clear;
close all;
tic;

%% create sensor nodes, set parameters and create energy model
%%%%%%%%%%%%%%%%%%%%%%% Initial parameters %%%%%%%%%%%%%%%%%%%%%%%

n = 40;                                     % number of Nodes in the field
d = 200;
m = 5;
Model = setParameters(n, d);                 % Set parameters Sensors and network

%%%%%%%%%%%%%%%%%%%%%% configuration Sensors %%%%%%%%%%%%%%%%%%%%%
CreateRandomLocation(Model);               %Crate a random Senario
load Locations                             % Load sensor Location
Sensors=ConfigureSensors(Model,n,X,Y);

%%%%%%%%%%%%%%%%%%%% parameters initialization %%%%%%%%%%%%%%%%%%%
flag_first_dead = 0;       % flag_first_dead
initEnergy = sum([Sensors(1:end-1).E]);          % initial Energy
AliveSensors=zeros(1,Model.rmax);
Delay=zeros(1,Model.rmax);
DelayE=zeros(1,Model.rmax);
DelayD=zeros(1,Model.rmax);
DelayR=zeros(1,Model.rmax);
Packetloss=zeros(1,Model.rmax);
PacketlossE=zeros(1,Model.rmax);
PacketlossD=zeros(1,Model.rmax);
PacketlossR=zeros(1,Model.rmax);

ConsumEnergy=zeros(1,Model.rmax);
D = Distance(Sensors, Model);

%%%%%%%%%%%%%%%%%%%%%%%%%% start simulation %%%%%%%%%%%%%%%%%%
global delayE delayD delayR lossE sentE lossD sentD lossR sentR pdr lossMat sentMat

%Sink broadcast start message to all nodes
Sensors = downwardBrodcasting(Sensors, Model, 'Hello', D);

%All sensor send location information to sink
%Sender=1:Model.n;     %All nodes
%Sensors = upwardBrodcasting(Sensors, Model, Sender, PacketType, D);

%% Step1: Layering Phase
Sensors = Layering(Sensors, Model, D);

%% main loop program
for r=1:1:Model.rmax
    delayE = 0; delayD = 0; delayR = 0;
    lossE = 0; sentE = 0; lossD = 0; sentD = 0; lossR = 0; sentR = 0;
    lossMat = zeros(n+1, n+1); sentMat = zeros(n+1, n+1);
    
    pause(0.001)     %pause simulation    
    hold off;        %clear figure
       
    [Sensors, mobileNodes, hisX, hisY] = RandomWalk(Sensors, Model, hisX, hisY);
    
    pdr = PacketDeliveryRatio(Model, D);
    
    D = Distance(Sensors, Model);
    
    Sensors = updateNeighbours(Sensors, Model, mobileNodes, D);
    
    Sensors = updateNeighboursTables(Sensors, Model, D);
    
    Sensors = Scheduling(Sensors, Model);
    
    Sensors = Sensing(Sensors, Model);
    
    Sensors = Proccessing(Sensors, Model);
    
    Sensors = SendCoordinators(Sensors, Model, r);
    
    Sensors = Routing(Sensors, Model, D, r);
    
    %updatepsucc_psent();
    deadNum=Plotter(Sensors,Model);

    %save r'th period when the first node dies
    if (deadNum>=1)
      if(flag_first_dead==0)
          first_dead=r;
          flag_first_dead=1;
      end
    end
    
    
    alive = n+n*m-deadNum;

    AliveSensors(r)=alive; 

    ResidualEnergyAllSensor=sum([Sensors(1:end-1).E]); 
    ConsumEnergy(r)=(initEnergy-ResidualEnergyAllSensor); 
    
    Delay(r)=(delayE + delayD + delayR)/Model.m;
    DelayE(r)=(delayE)/Model.m;
    DelayD(r)=(delayD)/Model.m;
    DelayR(r)=(delayR)/Model.m;
    Packetloss(r)=(lossE + lossD + lossR)/(sentE + sentD + sentR);
    PacketlossE(r)=(lossE)/(sentE);
    PacketlossD(r)=(lossD)/(sentD);
    PacketlossR(r)=(lossR)/(sentR);
    %psucc_psent = 1-(lossMat ./ sentMat);
    title(['round :' , num2str(r), ' dead nodes: ', num2str( deadNum)])

    %{
    if(deadNum >= n)
      break;
    end
    %}
end % for r=0:1:rmax

disp('End of Simulation')
toc;
reports.AliveSensors = AliveSensors;

reports.Delay = Delay;
reports.DelayE = DelayE;
reports.DelayD = DelayD;
reports.DelayR = DelayR;
reports.Packetloss = Packetloss;
reports.PacketlossE = PacketlossE;
reports.PacketlossD = PacketlossD;
reports.PacketlossR = PacketlossR;
%reports.First_dead = first_dead;

tempP = 0;
tempS = 0;
Model = setParameters(n, d);
for i=1:Model.n*Model.m
    tempP = tempP + ...
        (Model.DataPacketSize * Model.Niter * Model.Cavg * Model.Vsup^2 + ...
         Model.DataPacketSize * Model.Vsup * ...
        (Model.I0 * exp(1) ^ (Model.Vsup/(Model.Vt*Model.Proc))) * (Model.Niter/Model.f));
end

Processing = tempP;

for i=1:Model.n*Model.m     
    tempS = tempS + ...
    (Model.DataPacketSize * Model.Vsup * Model.Isens * Model.Tsens);
end
Senssing = tempS;

EengryRouting = ConsumEnergy - (Processing + Senssing)*Model.rmax;
reports.EengryRouting = EengryRouting;
reports.ConsumEnergy = ConsumEnergy + EengryRouting;

