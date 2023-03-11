function CreateRandomLocation(Model)

    n=Model.n;
    x=Model.dim;
    y = x;
    X=zeros(1,n);
    Y=X;
    for i=1:1:n
        X(i)=rand()*x;
        Y(i)=rand()*y;
    end
    history = 20;
    hisX = zeros(n, history); hisY = zeros(n, history);
    for i=1:1:n
        for j=1:1:history
            hisX(i, j) = rand();
            hisY(i, j) = rand();
        end
    end
    %RDelay = 10^-4 + rand(n, n)*(10^-3 - 10^-4);
    %RPacketloss = 10^-4 + rand(n+1, n+1)*(10^-3 - 10^-4);
    %for i=1:n
    %    RPacketloss(i,i) = 0;
    %end
                
    save ('Locations', 'X', 'Y', 'hisX', 'hisY');

end
