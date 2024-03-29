clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     1.0   %m
    g     9.81  %m/s/s
    w_f   60    %rad/s (base oscillation)
    a     0  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];


generate_single_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1, 0], @single_pendulum_func);
animate_eoms(time, state, @single_pendulum_spatial, 'single_drop');
