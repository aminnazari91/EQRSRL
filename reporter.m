function statistics = reporter(r,n,Sum_DEAD,StandardMembers,AliveSensors,ConsumEnergy,ResidualEnergyAllSensor,first_dead)
    round=1;
    Counter=0;
    for i=1:1:r
       if (mod(i,round)==0)
           Counter=Counter+1;
           statistics.Ali(Counter)=AliveSensors(i);
           
           statistics.Cons(Counter)=ConsumEnergy(i);
           %statistics.Avg(Counter)=AvgEnergyAllSensor(i);
           statistics.Res(Counter) = ResidualEnergyAllSensor(i);
           statistics.std(Counter) = StandardMembers(i);
           if (Sum_DEAD(i)>=((n*20)/100)), statistics.lifetime=i; end
           
           disp(['Number of Alive nodes in round ', num2str(i) ,' is ',num2str(AliveSensors(i))]);
           disp(['Consumption Energy in round ', num2str(i) ,' is ',num2str(ConsumEnergy(i))]);           
           disp(['Residual Energy in round ',num2str(i) ,' is ',num2str(ConsumEnergy(i))]);
           disp(['Standard Members of CHs in round ',num2str(i) ,' is ',num2str(StandardMembers(i))]);
       end
    end
    
    % FND  and HNA
    if (exist('first_dead','var'))
        statistics.firstDead=first_dead;
    end
    disp(['First Node Dead in Round ',num2str(first_dead)]);
    disp(['Life time network based on dead 20% nodes ',num2str(statistics.lifetime)]);

end
