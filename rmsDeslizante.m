% rmsDeslizante.m
function [vrms, tvec] = rmsDeslizante(v, fs, win_ms)
v = v(:);
Nw = max(1, round((win_ms/1000)*fs));
w = ones(Nw,1)/Nw;
m2 = conv(v.^2, w, 'same');
vrms = sqrt(m2);
tvec = (0:numel(v)-1)'/fs;
end
