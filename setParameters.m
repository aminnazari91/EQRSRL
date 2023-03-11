function Model = setParameters(n, dim)
Model.n = n;
Model.m = 5;
Model.dim = dim;
%Sink Motion pattern 
Model.Sinkx=dim/2;
Model.Sinky=dim/2;

%Initial Energy 
Model.En=5;
Model.Ec=10;

%Eelec=Etx=Erx
Model.ETX=50*10^-9;
Model.ERX=50*10^-9;

%Transmit Amplifier types
Model.Efs=10*10^-12;
Model.Emp=0.0013*10^-12;

%Data Aggregation Energy
Model.EDA=5*10^-9;

%Computation of do
Model.d0=sqrt(Model.Efs/Model.Emp);

%maximum number of rounds
Model.rmax=360;

%Data packet size
Model.DataPacketSize=32;

%Hello packet size
Model.HelloPacketSize=8;

%Number of Packets sended in steady-state phase
Model.NumPacket=50;

%Redio Range
Model.RR=50;
Model.inRR=1;

% Vsup
Model.Vsup = 2.7;

% Isens
Model.Isens = 25 * 10^-3 ;

% Tsen
Model.Tsens = 0.5 * 10^-3 ;

Model.Niter = 0.97*10^6;
Model.f = 191.42*10^6;
Model.Cavg = 22*10^-12;
Model.I0 = 1.196*10^-3;
Model.Vt = 0.2;
Model.Proc = 21.26 ;

Model.IA = 8 * 10^-3;
Model.IS = 1 * 10^-6;
Model.TAN = 10^-3;
Model.TACH = 10 *10^-3;
Model.TranON = 2450*10^-6;
Model.TranOFF = 250*10^-6;
Model.TS = 299 * 10^-3;
Model.TSCH = 290 * 10^-3;

Model.CN = (Model.TranON + Model.TAN + Model.TranOFF)/(Model.TranON + Model.TAN + Model.TranOFF + Model.TS);
Model.CCH = (Model.TranON + Model.TACH + Model.TranOFF)/(Model.TranON + Model.TACH + Model.TranOFF + Model.TSCH);

Model.Vmax = 2;
Model.Vmin = 0;

Model.C = 3*10^8;   %light speed
Model.TR = 10*1024; %10Kbps

end
