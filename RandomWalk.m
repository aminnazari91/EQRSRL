function [Sensors, np, velX, velY] = RandomWalk(Sensors, Model, velX, velY)

    np = randsample(Model.n, floor(Model.n*0.1));
    for i=1:length(np)
        ux = mean(velX(np(i),:));
        uy = mean(velY(np(i),:));

        n = 20; k = floor(n/2); sx = 0;  sy = 0;

        for j=1:n-k
            sy = sy + (velY(np(i),j)-uy)*(velY(np(i),j+k)-uy);
            sx = sx + (velX(np(i),j)-ux)*(velX(np(i),j+k)-ux);
        end
        sx = sx/n;
        sy = sy/n;

        velX(np(i),1:n-1) = velX(np(i), 2:end);
        velX(np(i),n) = abs(velX(np(i),n) + sx);

        velY(np(i),1:n-1) = velY(np(i),2:end);
        velY(np(i),n) = abs(velY(np(i),n) + sx);

        u = [ux, uy];
        vXY = [velX(np(i),end),velY(np(i), end)];

        J = cov(velX(np(i),:),velY(np(i),:));
        B = BrownianMotion();
        dt = 1/n;
        teta = rand()*2*pi;

        m1 = [[-log(abs(sx)), teta]; [-teta, -log(abs(sy))]];

        dv = (-m1 * (vXY-u)')*dt + (J * B')*dt;
        idx = Model.n*Model.m+np(i);
        Sensors(idx).x = abs(Sensors(idx).x + dv(1)); 
        Sensors(idx).y = abs(Sensors(idx).y + dv(2)); 

    end
    %{

    np = randsample(Model.n, floor(Model.n*0.1));
    for i=1:length(np)
        idx = Model.n*Model.m+np(i);
        Sensors(idx).x = abs(Sensors(idx).x + randn()); 
        Sensors(idx).y = abs(Sensors(idx).y + randn());
    end
    %}
    for i=1:Model.m*Model.n
        %set x location
        idx = ceil(i/Model.m);
        idx = Model.m*Model.n + idx;
        Sensors(i).x=Sensors(idx).x+rand()/5; 
        %set y location
        Sensors(i).y=Sensors(idx).y+rand()/5;
    end
end

