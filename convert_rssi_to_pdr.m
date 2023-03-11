
function pdr = convert_rssi_to_pdr(rssi)

    RSSI_PDR_TABLE = [
        -97,    0.0000;  % this value is not from experiment
        -96,    0.1494;
        -95,    0.2340;
        -94,    0.4071;
        % <-- 50% PDR is here; at RSSI=-93.6
        -93,    0.6359;
        -92,    0.6866;
        -91,    0.7476;
        -90,    0.8603;
        -89,    0.8702;
        -88,    0.9324;
        -87,    0.9427;
        -86,    0.9562;
        -85,    0.9611;
        -84,    0.9739;
        -83,    0.9745;
        -82,    0.9844;
        -81,    0.9854;
        -80,    0.9903;
        -79,    1.0000;  % this value is not from experiment
    ];
    minRssi = RSSI_PDR_TABLE(1, 1);
    maxRssi = RSSI_PDR_TABLE(end, 1);

    if rssi < minRssi
        pdr = 0.0;
    elseif rssi > maxRssi
        pdr = 1.0;
    else
        floor_rssi = floor(rssi);
        pdr_low    = RSSI_PDR_TABLE(RSSI_PDR_TABLE==floor_rssi, 2);
        pdr_high   = RSSI_PDR_TABLE(RSSI_PDR_TABLE==floor_rssi+1, 2);
        % linear interpolation
        pdr = (pdr_high - pdr_low) * (rssi - floor_rssi) + pdr_low;
    end
end