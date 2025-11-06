% calcFFT.m
function [f, mag] = calcFFT(v, fs)
v = v(:);
N = numel(v);
Y = fft(v);
P2 = abs(Y)/N;
if mod(N,2)==0
    P1 = P2(1:N/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:(N/2))/N;
else
    P1 = P2(1:(N+1)/2);
    P1(2:end) = 2*P1(2:end);
    f = fs*(0:((N-1)/2))/N;
end
mag = P1;
end
