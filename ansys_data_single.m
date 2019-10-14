clf
close all
clear

addpath lib functions eom data

load sdofkapitza

t = data.time;
y = data.theta1 / 180 * pi;
y = y - mean(y);

[Fv, FTs] = generate_fft(t, y);
plot_fft(Fv, FTs, 'ANSYS Model - Single Kapitza FFT', [0 50], [7*10^-6 1]);
saveas(gcf, 'figures/ansys_single_fft.png');

clf
plot_time_signal(t, y, 'ANSYS Model - Single Kapitza', [0 3], 'Pendulum Angle');
saveas(gcf, 'figures/ansys_single_time.png');
