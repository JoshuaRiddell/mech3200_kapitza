clf
close all
clear

addpath lib functions eom

setup

% parameters to be subsituted into the model
values = [
    m     1.0   %kg
    l     1.1   %m
    g     9.81  %m/s/s
    w_f   62.8    %rad/s (base oscillation)
    a     0.11  %m (base oscillation)
    c     0.09 %N.s (axial damping)
    k     50
];

f = sqrt(k/m/l^2 - g/l) / (2*pi);
eval(subs(f, values(:,1), values(:,2)))

generate_single_spring_pendulum_eom(values);
[time, state] = simulate_eoms(10, [0.1, 0], @single_spring_pendulum_func);
% animate_eoms(time, state, @single_spring_pendulum_spatial, 'single');
