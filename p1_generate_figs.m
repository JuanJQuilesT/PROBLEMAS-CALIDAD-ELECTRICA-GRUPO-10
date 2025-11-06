% p1_generate_figs.m
function p1_generate_figs()
if ~exist('figures','dir'); mkdir figures; end
% Ejercicio 1.1
fs = 1000; dur = 0.1; f0 = 50; Vp = 325;
t = (0:1/fs:dur).'; v = Vp*sin(2*pi*f0*t);
Vrms = calcRMS(v);
figure('Position',[100 100 900 350]);
plot(t*1000, v, 'LineWidth', 1.1); grid on;
xlabel('Tiempo (ms)'); ylabel('Voltaje (V)');
title(sprintf('Sinusoidal 50 Hz | V_{RMS}=%.2f V', Vrms));
saveas(gcf, fullfile('figures','fig_p1_sinusoid.png'));

% Ejercicio 1.2
[~, tzc, f_est] = detectCrucesCero(v, fs);
figure('Position',[100 500 900 350]);
plot(t*1000, v, 'LineWidth', 1.1); grid on; hold on;
plot(tzc*1000, zeros(size(tzc)), 'or', 'MarkerSize', 6, 'LineWidth', 1.3);
xlabel('Tiempo (ms)'); ylabel('Voltaje (V)');
title(sprintf('Cruces por cero | f_{est}=%.2f Hz', f_est));
saveas(gcf, fullfile('figures','fig_p1_zero.png'));

% Ejercicio 1.3 + Actividad
fs = 2000; dur = 0.2; t = (0:1/fs:dur).'; Vp = 325;
v = Vp*sin(2*pi*50*t); t0=0.050; t1=0.100;
idx = (t>=t0) & (t<t1); v(idx) = 0.5*Vp.*sin(2*pi*50*t(idx));
figure('Position',[1050 100 900 350]);
plot(t*1000, v, 'LineWidth', 1.1); grid on;
xlabel('Tiempo (ms)'); ylabel('Voltaje (V)');
title('Señal con hueco del 50% (50–100 ms)');
saveas(gcf, fullfile('figures','fig_p1_hole_signal.png'));
[vrms, tvec] = rmsDeslizante(v, fs, 20);
figure('Position',[1050 500 900 350]);
plot(tvec*1000, vrms, 'LineWidth', 1.3); grid on; hold on;
yline(230,'--'); yline(207,':'); yline(253,':');
xlabel('Tiempo (ms)'); ylabel('RMS (V)');
title('RMS deslizante (ventana 20 ms)');
legend('RMS','230 V','-10%','+10%','Location','best');
saveas(gcf, fullfile('figures','fig_p1_hole_rms.png'));
close all;
end
