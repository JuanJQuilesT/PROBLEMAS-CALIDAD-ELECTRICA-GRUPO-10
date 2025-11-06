% analizaArmonicos.m
function [tabla, THD_pct] = analizaArmonicos(v, fs, f0, maxN)
if nargin < 4, maxN = 15; end
[f, mag] = calcFFT(v, fs);
Vn = zeros(maxN,1);
fn = zeros(maxN,1);
for n = 1:maxN
    target = n*f0;
    [~, idx] = min(abs(f - target));
    fn(n) = f(idx);
    Vn(n) = mag(idx);
end
V1 = Vn(1);
porc = 100*(Vn./V1);
THD_pct = 100*sqrt(sum((Vn(2:end)./V1).^2));
tabla = table((1:maxN)', fn, Vn, porc, ...
    'VariableNames', {'n','f_Hz','Magnitud','Porc_sobre_fundamental'});
end
