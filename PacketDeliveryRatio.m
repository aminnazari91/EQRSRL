function PDR = PacketDeliveryRatio(Model, D)
    n = Model.n;
    m = Model.m;
    PDR = ones(n+1, n+1);
    
    for i=n*m+1:n+n*m+1
        for j=i+1:n+n*m+1
            dist = D(i, j);
            rssi = compute_rssi(dist);
            pdr = convert_rssi_to_pdr(rssi);
            PDR(i-n*m,j-n*m) = pdr;
            PDR(j-n*m,i-n*m) = pdr;
        end
    end
end
