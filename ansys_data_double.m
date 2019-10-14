clf
close all
clear

addpath lib functions eom data

load ddofkapitza

t = data1.time;
y1 = data1.theta1 / 180 * pi;
y2 = data2.theta2 / 180 * pi;
y1 = y1 - mean(y1);
y2 = y2 - mean(y2);

y = [y1, y2];

[Fv, FTs] = generate_fft(t, y);
plot_fft(Fv, FTs, 'ANSYS Model - Double Kapitza FFT', [0 50], [7*10^-6 1], {'Pendulum 1 Angle', 'Pendulum 2 Angle'});
saveas(gcf, 'figures/ansys_double_fft.png');

clf
plot_time_signal(t, y, 'ANSYS Model - Double Kapitza', [0 7], 'Pendulum Angle');
saveas(gcf, 'figures/ansys_double_time.png');
