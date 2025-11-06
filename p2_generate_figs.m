% p2_generate_figs.m
function p2_generate_figs()
if ~exist('figures','dir'); mkdir figures; end
% Señal pura
fs = 2000; dur = 1.0; f0 = 50; Vp = 325;
t = (0:1/fs:dur).'; v = Vp*sin(2*pi*f0*t);
[f, mag] = calcFFT(v, fs);
figure('Position',[100 100 900 350]);
stem(f(f<=500), mag(f<=500), 'filled'); grid on;
xlabel('Frecuencia (Hz)'); ylabel('Magnitud (V)');
title('Espectro: sinusoidal pura 50 Hz');
saveas(gcf, fullfile('figures','fig_p2_spectrum_pure.png'));
% Señal con armónicos
dur = 0.5; t = (0:1/fs:dur).';
v = Vp*sin(2*pi*f0*t)+0.15*Vp*sin(2*pi*3*f0*t)+0.10*Vp*sin(2*pi*5*f0*t);
figure('Position',[100 500 900 350]);
idx = t <= 4*(1/f0);
plot(t(idx)*1000, v(idx), 'LineWidth', 1.1); grid on;
xlabel('Tiempo (ms)'); ylabel('Voltaje (V)');
title('Señal compuesta (primeros 4 ciclos)');
saveas(gcf, fullfile('figures','fig_p2_wave_4cycles.png'));
[tab, THD_pct] = analizaArmonicos(v, fs, f0, 15);
figure('Position',[1050 100 900 350]);
bar(tab.n(1:10), tab.Magnitud(1:10)); grid on;
xlabel('Armónico'); ylabel('Magnitud (V)');
title(sprintf('Armónicos (1..10) | THD=%.2f %%', THD_pct));
saveas(gcf, fullfile('figures','fig_p2_harmonics.png'));
close all;
end
