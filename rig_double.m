clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     0.15   %m
    g     9.81  %m/s/s
    w_f   2*pi*31    %rad/s (base oscillation)
    a     0.01  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];




generate_double_pendulum_eom(values);
[time, state] = simulate_eoms(20, [0.1; 0; 0; 0], @double_pendulum_func);
animate_eoms(time, state, @double_pendulum_spatial, 'rig_double');

% [~, FTs1] = generate_fft(time, state(:,1));
% [Fv, FTs2] = generate_fft(time, state(:,3));
% FTs = [FTs1, FTs2];
% plot_fft(Fv, FTs, 'MATLAB Model - Double Kapitza FFT', [0 50], [3*10^-6 0.2], {'Pendulum 1 Angle', 'Pendulum 2 Angle'});
% saveas(gcf, 'figures/double_fft.png');

% clf
% plot_time_signal(time, [state(:,1), state(:,3)], 'MATLAB Model - Double Kapitza', [0 7], {'Pendulum 1 Angle', 'Pendulum 2 Angle'});
% saveas(gcf, 'figures/double_time.png');
