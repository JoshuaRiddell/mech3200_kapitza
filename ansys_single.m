clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     0.95   %m
    g     9.81  %m/s/s
    w_f   200    %rad/s (base oscillation)
    a     0.03  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];

generate_single_pendulum_eom(values);

[time, state] = simulate_eoms(20, [0.1, 0], @single_pendulum_func);
animate_eoms(time, state, @single_pendulum_spatial, 'ansys_single');

[Fv, FTs] = generate_fft(time, state(:,1));
plot_fft(Fv, FTs, 'MATLAB Model - Single Kapitza FFT', [0 50], [3*10^-6 0.2]);
saveas(gcf, 'figures/single_fft.png');

clf
plot_time_signal(time, state(:,1), 'MATLAB Model - Single Kapitza', [0 3], 'Pendulum Angle');
saveas(gcf, 'figures/single_time.png');