clf
close all

addpath lib functions eom

single_pendulum_eom
[time, state] = simulate_eoms(0, 30, [0.1, 0], @single_pendulum_func);
animate_eoms(time, state, @single_pendulum_spatial, 'single');
