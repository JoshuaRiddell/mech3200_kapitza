clf
close all

addpath lib functions eom

double_pendulum_eom
[time, state] = simulate_eoms(0, 10, [0.1; 0; 0; 0], @double_pendulum_func);
animate_eoms(time, state, @double_pendulum_spatial, 'double');
