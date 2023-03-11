function rssi = compute_mean_rssi(distance, PISTER_HACK_LOWER_SHIFT)
    
    TWO_DOT_FOUR_GHZ         = 2400000000; % Hz
    SPEED_OF_LIGHT           =  299792458; % m/s
    txPower = 0;
    antennaGain = 0;
    % sqrt and inverse of the free space path loss (fspl)
    free_space_path_loss = SPEED_OF_LIGHT / (4 * pi * distance * TWO_DOT_FOUR_GHZ);

    % simple friis equation in Pr = Pt + Gt + Gr + 20log10(fspl)
    pr = txPower + antennaGain + antennaGain + (20 * log10(free_space_path_loss));

    % according to the receiver power (RSSI) we can apply the Pister hack
    % model.
    % choosing the "mean" value
    rssi = pr - (PISTER_HACK_LOWER_SHIFT / 2);
end
