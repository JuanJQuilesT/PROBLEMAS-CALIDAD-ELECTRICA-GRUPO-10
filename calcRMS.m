% calcRMS.m
function Vrms = calcRMS(v)
v = v(:);
Vrms = sqrt(mean(v.^2));
end
