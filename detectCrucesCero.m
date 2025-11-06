% detectCrucesCero.m
function [idx, tzc, f_est] = detectCrucesCero(v, fs)
v = v(:);
sg = sign(v);
zc = find(sg(1:end-1).*sg(2:end) < 0);
tzc = zeros(numel(zc),1);
idx = zc;
for k = 1:numel(zc)
    n = zc(k);
    denom = (v(n+1) - v(n));
    if denom == 0
        alpha = 0.5;
    else
        alpha = -v(n) / denom;
        alpha = max(0,min(1,alpha));
    end
    tzc(k) = (n-1 + alpha)/fs;
end
f_est = NaN;
if numel(tzc) >= 3
    dt_half = diff(tzc);
    T_est = 2*mean(dt_half);
    f_est  = 1/T_est;
end
end
