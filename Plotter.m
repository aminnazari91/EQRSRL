function deadNum=Plotter(Sensors,Model)
    
    deadNum=0;
    n=Model.n*Model.m+Model.n;
    for i=1:n
        %check dead node
        if (Sensors(i).E>0)
            
            if(Sensors(i).type=='N' )      
                plot(Sensors(i).x,Sensors(i).y,'o');     
            else %Sensors.type=='C'       
                plot(Sensors(i).x,Sensors(i).y,'kx','MarkerSize',10);
            end
            
        else
            deadNum=deadNum+1;
            plot(Sensors(i).x,Sensors(i).y,'red .');
        end
        
        hold on;
        
    end 
    plot(Sensors(n+1).x,Sensors(n+1).y,'g*','MarkerSize',15); 
    axis square

end
