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
    w_f   3000*2*pi/60    %rad/s (base oscillation)
    a     0  %m (base oscillation)
    c     0.09 %N.s (axial damping)
];

generate_double_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1; 0; 0.1; 0], @double_pendulum_func);
animate_eoms(time, state, @double_pendulum_spatial, 'double_drop');

