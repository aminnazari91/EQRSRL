
function  rssi = compute_rssi(distance)
    PISTER_HACK_LOWER_SHIFT  =         40; % dB
    %"""Compute RSSI between the points of a and b using Pister Hack"""

    % compute the mean RSSI (== friis - 20)
    mu = compute_mean_rssi(distance, PISTER_HACK_LOWER_SHIFT);

    % the receiver will receive the packet with an rssi uniformly
    % distributed between friis and (friis - 40)
    rssi = mu; %+ unifrnd((-PISTER_HACK_LOWER_SHIFT/2), (+PISTER_HACK_LOWER_SHIFT/2));
end