function dist=Distance(Sensors,Model)
    
    n=Model.n+Model.n*Model.m+1;
    dist=inf(n,n);
    thershold=Model.RR;
    for i=1:n
        for j=i+1:n     
            temp=sqrt((Sensors(i).x-Sensors(j).x)^2+(Sensors(i).y-Sensors(j).y)^2);
            if (temp<=thershold && Sensors(i).E>0 && Sensors(j).E>0)
                if(strcmp(Sensors(i).type ,'C')&& strcmp(Sensors(j).type ,'C'))
                    dist(i,j)=temp;
                end
            end
            if (temp<=2 && Sensors(i).E>0 && Sensors(j).E>0)
                dist(i,j)=temp;
            end
            dist(j,i)=dist(i,j);
        end
    end
   
end