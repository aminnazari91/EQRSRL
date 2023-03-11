function  B = BrownianMotion()
        n = 20;
        dt = 1/n ;                        
        dB = 0; 
        dC = 0;
        for i=1:n
            dB = dB + sqrt(dt)*rand();
            dC = dC + sqrt(dt)*rand();     
        end
        B = [dB, dC];
end