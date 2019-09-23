clf
close all

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     1.0   %m
    g     9.81  %m/s/s
    w_f   50   %rad/s (base oscillation)
    a     0.05 %m (base oscillation)
];

double_pendulum_eom
[time, state] = simulate_eoms(0, 10, [0.1; 0; 0; 0], @double_pendulum_func);
animate_eoms(time, state, @double_pendulum_spatial, 'double');
