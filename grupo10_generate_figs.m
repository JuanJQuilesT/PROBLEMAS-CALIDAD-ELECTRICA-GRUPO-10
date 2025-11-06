% grupo10_generate_figs.m
function grupo10_generate_figs()
if ~exist('figures','dir'); mkdir figures; end
fs=2000; Ttot=0.700; f0=50; Vp=325; t=(0:1/fs:Ttot).';
t_hueco_ini=0.100; t_hueco_dur=0.060; t_estable_dur=0.300; t_ov_dur=0.050;
t_hueco_fin=t_hueco_ini+t_hueco_dur; t_estable_ini=t_hueco_fin;
t_estable_fin=t_estable_ini+t_estable_dur; t_ov_ini=t_estable_fin; t_ov_fin=t_ov_ini+t_ov_dur;
fac_hueco=0.70; fac_ov=1.20; a3=0.08; a5=0.05;
v=Vp*sin(2*pi*f0*t);
idx_hueco=(t>=t_hueco_ini)&(t<t_hueco_fin);
v(idx_hueco)=fac_hueco*Vp.*sin(2*pi*f0*t(idx_hueco));
idx_est=(t>=t_estable_ini)&(t<t_estable_fin);
v(idx_est)=Vp.*sin(2*pi*f0*t(idx_est))+a3*Vp.*sin(2*pi*(3*f0)*t(idx_est))+a5*Vp.*sin(2*pi*(5*f0)*t(idx_est));
idx_ov=(t>=t_ov_ini)&(t<t_ov_fin);
v(idx_ov)=fac_ov*Vp.*sin(2*pi*f0*t(idx_ov));
% Señal completa
Vrms_global = calcRMS(v);
figure('Position',[100 100 1100 420]);
plot(t*1000, v,'LineWidth',1.1); grid on; hold on;
yl=ylim;
plot([t_hueco_ini t_hueco_ini]*1000, yl,'--k');
plot([t_hueco_fin t_hueco_fin]*1000, yl,'--k');
plot([t_estable_ini t_estable_ini]*1000, yl,':k');
plot([t_estable_fin t_estable_fin]*1000, yl,':k');
plot([t_ov_ini t_ov_ini]*1000, yl,'-.k');
plot([t_ov_fin t_ov_fin]*1000, yl,'-.k');
xlabel('Tiempo (ms)'); ylabel('Voltaje (V)');
title(sprintf('Señal completa | V_{RMS}=%.2f V', Vrms_global));
legend({'v(t)','ini hueco','fin hueco','ini estable','fin estable','ini sobretensión','fin sobretensión'},'Location','bestoutside');
saveas(gcf, fullfile('figures','fig_senal_completa.png'));
% RMS deslizante
[vrms,t_rms]=rmsDeslizante(v,fs,20);
figure('Position',[100 560 1100 420]);
plot(t_rms*1000, vrms,'LineWidth',1.2); grid on; hold on;
yline(230,'--k'); yline(207,':k'); yline(253,':k');
xlabel('Tiempo (ms)'); ylabel('RMS (V)');
title('RMS deslizante (ventana 20 ms)');
saveas(gcf, fullfile('figures','fig_RMS.png'));
% Espectro fase estable
v_est = v(idx_est);
[f, mag]=calcFFT(v_est,fs);
figure('Position',[1250 100 900 420]);
fmax=500;
stem(f(f<=fmax), mag(f<=fmax), 'filled','k'); grid on;
xlabel('Frecuencia (Hz)'); ylabel('Magnitud (V)');
title('Espectro (fase estable)');
saveas(gcf, fullfile('figures','fig_fft.png'));
% Armónicos
[tab,THD_pct]=analizaArmonicos(v_est,fs,50,15);
figure('Position',[1250 560 900 420]);
bar(tab.n(1:10), tab.Magnitud(1:10), 'k'); grid on;
xlabel('nº de armónico'); ylabel('Magnitud (V)');
title(sprintf('Primeros 10 armónicos | THD = %.2f %%', THD_pct));
saveas(gcf, fullfile('figures','fig_armonicos.png'));
close all;
end
